---
name: combine-videos
description: Concatenate video segments (MKV/TS/MP4) into a single .mp4 in natural numeric order, lossless via stream-copy, with Apple-compatible HEVC tagging so macOS Finder recognizes it (thumbnail, Quick Look, QuickTime). Use when the user asks to "combine/concat/merge videos", especially numbered segments or HLS/m3u8 chunks.
---

# Combine videos into a single Finder-ready .mp4

## When to use

- User has multiple video segments in a directory and wants them combined.
- Filenames are numeric (e.g. `33.mkv`, `94.mkv`, `155.mkv`) — lexicographic sort is wrong; need natural numeric sort.
- An `index.m3u8` (HLS playlist) is present — its order is authoritative; use it instead of guessing.
- Output must play in macOS Finder/QuickTime with thumbnails (HEVC requires `hvc1` tag, not `hev1`).

## Procedure

### 1. Determine order

- If `index.m3u8` exists: parse the listed filenames in order. The `#EXTINF` values are *target* durations and may exceed actual segment length — don't trust them for verification.
- Else: natural-sort filenames numerically (e.g. `ls | sort -V`).

### 2. Verify segments are concat-copy compatible

```bash
for f in <segments>; do
  ffprobe -v error -show_entries stream=codec_name,width,height,pix_fmt,r_frame_rate \
    -of default=nw=1 "$f"
done
```

Codec, resolution, and pixel format must match. Frame rate may differ slightly (e.g. 30/1 vs 30000/1001) — concat-copy still works for video-only; for files with audio, mismatched timebases can cause drift.

### 3. Build concat list and mux

```bash
# in the video directory
printf "file '%s'\n" <ordered-segments> > concat_list.txt

ffmpeg -hide_banner -y -f concat -safe 0 -i concat_list.txt \
  -c copy -tag:v hvc1 -movflags +faststart combined.mp4

rm concat_list.txt
```

Flags explained:
- `-c copy` — no re-encode, lossless, fast.
- `-tag:v hvc1` — **critical for macOS**: Apple's QuickTime/Finder require `hvc1`; the default `hev1` shows as an unrecognized file with no thumbnail.
- `-movflags +faststart` — moves the `moov` atom to the front for instant Finder preview.
- `-f concat -safe 0` — concat demuxer; `-safe 0` allows relative paths.

For non-HEVC sources, drop `-tag:v hvc1`. For H.264, the default tag (`avc1`) is already Finder-compatible.

### 4. Verify output

```bash
ffprobe -v error -show_entries format=duration:stream=codec_name,codec_tag_string \
  -of default=nw=1 combined.mp4
mdls -name kMDItemKind -name kMDItemContentType combined.mp4
```

Expect `codec_tag_string=hvc1` (for HEVC) and `kMDItemKind = "MPEG-4 movie"`.

## Gotchas

- **Matroska duration may report `N/A`** if recording was interrupted — the `SegmentInfo` header was never patched. Remuxing (`ffmpeg -i bad.mkv -c copy fixed.mkv`) recomputes it from cluster timestamps. The original is still concat-able; only duration metadata is broken.
- **m3u8 `#EXTINF` is aspirational**: actual segment content can be shorter. If output duration looks short, sum each segment's real duration before assuming data was lost.
- **Don't feed `index.m3u8` to `ffmpeg -i` for local MKV concat** — the HLS demuxer expects MPEG-TS segments and rejects standalone MKV. Use the concat demuxer with an explicit list.
- **Audio**: if segments have audio, add `-c:a copy` (already covered by `-c copy`) and watch for timebase drift. If sync drifts, re-encode audio: `-c:v copy -c:a aac`.
