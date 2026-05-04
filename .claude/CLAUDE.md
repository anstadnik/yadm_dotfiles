# User: Andrii Stadnik

## Communication
- Keep responses short and direct. No trailing summaries.
- Minimize words without losing substance: every important fact must be there and the message must stay understandable, but cut everything else -- hedging, restating the question, recapping prior turns, decorative structure.
- Front-load the answer. I interrupt when I have what I need.
- State assumptions explicitly. If uncertain, ask -- don't hide confusion.
- If multiple interpretations exist, present them; don't pick silently.
- If the request seems overcomplicated, name the simpler alternative once, then defer to me.

## Git Safety
- NEVER run `git reset --hard` or `git clean -fd` without explicit user confirmation
- ALWAYS run `git status` before `git diff` or any destructive git operation to understand the working tree state
- Before staging with `git add -A`, verify no untracked files (model checkpoints, scripts, videos, .DS_Store) would be affected
- For commit message edits only, prefer `git filter-branch --msg-filter` over rebase-merges to avoid tree divergence

## Planning Before Action
- For any multi-file change, refactor, or experiment, produce a concrete plan (no conditionals like 'if X then Y') and wait for approval before editing
- Do NOT dispatch subagents or begin edits until the documented workflow in progress.md (or equivalent) has been set up
- Verify assumptions visually/empirically (e.g., look at data, run a probe script) before writing code that depends on them
- Define a concrete check (test, probe, manual repro) that proves done before starting; for multi-step tasks, list each step with its verification check.

## Workflow
- Plan before big refactors (use plan mode). Small fixes: just do it.
- Ask clarifying questions before resolving merge conflicts.
- Write findings to .md files after extended debugging/profiling sessions.

## Sandbox & Permissions
- If the sandbox blocks an action you need to take to complete the user's request, stop and ask for explicit approval -- don't silently work around it with a worse path. State exactly what was blocked, what you'd do if approved, and what the cheaper fallback is. Wait for the user to say "go".
- Same when a tool denies an action mid-task. Don't quietly switch to a degraded approach; flag the gap so the user can either approve the original or accept the degraded one knowingly.

## Tooling
- Python: use `uv` (not pip, not python3). Run scripts with `uv run`.
- For ad-hoc data processing on log files / TSVs / sweep outputs, prefer `uvx --from polars-cli polars` or `uv run --with polars python -c '...'` over hand-rolled awk pipelines. Polars handles grouping/percentile/joins cleanly without saving intermediate files.
- Build: prefer Ninja (`-G Ninja`).
- Editor: Zed
- Model: Opus

## Shell & Build Conventions
- The user's interactive shell is fish; when writing shell snippets that use bash-isms (`[[ ]]`, arrays), invoke `bash -c '...'` explicitly
- After editing `CMAKE_*_FLAGS_INIT` or toolchain files, delete the CMake cache before rebuilding
- When cross-compiling on macOS for ARM ELF, do not rely on host `ar`; use the toolchain's archiver
- Prefer `fd` over `find` and `rg` over `grep` -- they're installed and respect `.gitignore`/skip cruft by default, which is dramatically faster on large trees (especially network mounts like `/Volumes/firmware_cs`).
- Wrap any potentially-slow search/scan command in a host-side timeout (e.g. `gtimeout 30 fd ...` or pass `timeout` to the tool when available). On the drone via `adb shell`, prefix with `timeout 10 ...` for the drone-side command. Long unbounded scans on SMB-mounted volumes can take 5+ minutes; bound them up front.

## Surgical Changes
- Touch only what the request requires. Every changed line should trace to the user's ask.
- Don't "improve" adjacent code, comments, or formatting; match existing style even if you'd write it differently.
- Don't refactor things that aren't broken. Mention unrelated dead code -- don't delete it unasked.
- Remove imports/variables/functions that *your* edits orphaned. Leave pre-existing dead code alone.
- Exception: if adjacent code is the root cause of the bug, fix it and say so.
- If the diff is materially larger than the request implies, stop and flag it.

## Code style
- Prefer return values over mutable-ref side effects. Reduce global/class state.
- Explicit parameters, no hidden defaults.
- Doxygen in headers only, not in .cpp files.
- Consider performance implications of changes.
- Prefer standard library over custom abstractions.
- Minimum code that solves the problem -- nothing speculative. No features, abstractions, "flexibility", or error handling for impossible scenarios beyond what was asked.