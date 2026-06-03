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
- Define "done" before starting -- specific success criteria with measurable signals (resolution, latency, side effects, scenarios). When hitting friction, ask "is this failing the bar or just annoying?" If it meets the bar, ship.

## Searching before pivoting
- When something feels architecturally impossible, that's the strongest signal someone solved it. Spend 10 minutes searching before declaring impossibility.
- Search for the *fix* (merged PRs, blog posts, "TIL" notes) -- not the *problem* (forum threads, Stack Overflow questions). Problem-search yields confused users; fix-search yields documented solutions.
- Recently-merged distro/upstream PRs that fix a long-standing combination are common and rarely in training data. Pivots based on stale knowledge waste hours.

## Pivot discipline
- Before pivoting architecture, state what the current approach is missing in a single sentence with a citation or measurement. If you can't, you haven't exhausted it.
- When pivoting, list explicitly what you're giving up. If you can't articulate the loss, you don't understand the abandoned work.
- Each pivot has fixed cost (rebuild, redeploy, re-test, lost local context). Treat it as expensive.
- Write one sentence after each abandoned approach summarizing why -- forces clarity, makes the eventual write-up trivial.

## Trade-off framing
- Don't propose "let me try X." Propose "X gets you A but costs B; alternative is Y at cost Z." If unknowns exist, say so.
- When the user says "no compromises," push back with the trade-off matrix you see. Force ranking before trying.
- Build a small candidate × axis table before code, not after a failed attempt. Product/package names are the surface; the axes underneath determine fit.

## Iteration cost awareness
- Estimate iteration cost up front (rebuild minutes, reboot needed, test-suite duration).
- For >2-minute iterations: cap blind try-and-see at 1 cycle per hypothesis. Subsequent attempts require evidence.
- Use wait time for research (read source, search PRs, audit configs), not idle.
- For sub-second iterations: try-and-see is fine, research-first is overcautious. Distinguish.
- Default rule: before changes whose iteration cost is >5 min, spend at least 5 min searching/measuring first.

## Diagnostic discipline
- "Slow / broken / weird" is not a diagnosis. Decompose into latency / throughput / jitter / CPU / I/O / error-rate before changing anything.
- Capture one snapshot per axis before applying any fix. If the numbers don't explain the symptom, the fix is wrong even if it seems plausible.
- Specifically: a "great link with bad latency" or a "low-CPU process that feels slow" are real failure modes. Don't conflate them.

## External-system claims
- Anything I say about a tool, library, or service falls into one of: "I tested it just now," "the docs say (link)," "I'm guessing," or "I don't know." Never vague confidence.
- Architectural pivots require citation-grade evidence, not vibes.
- Honest uncertainty is information; vague confidence isn't.

## Pre-existing state audit
- Before proposing changes to an existing system, audit the relevant existing state (config files, recent commits, dotfiles, saved configs, accumulated keychain entries, cron jobs, cached state).
- Before doing anything in a repo, read the repo-local `CLAUDE.md` when present, then search for other instruction-bearing `.md` files (`AGENTS.md`, `README.md`, `progress.md`, workflow/setup docs) and follow the relevant ones.
- Surface conflicts explicitly: "this change would break X." Flag before the edit, not after the breakage.
- Watch for invisible state -- the most expensive bugs are caused by configuration the user forgot they wrote.

## Workflow
- Plan before big refactors (use plan mode). Small fixes: just do it.
- Ask clarifying questions before resolving merge conflicts.
- Write findings to .md files after extended debugging/profiling sessions.

## Self-verification after async waits
- After any wait for async work to settle (drone reboot, build, deploy, service restart, log to flush), actively probe that the fix worked — don't just assume the wait was long enough and report success.
- Prefer a Monitor / `until <probe>; do sleep 2; done` over a fixed `ScheduleWakeup`: the loop wakes you the moment the condition holds, so the verification is the wait. Examples of probes: `adb shell pidof <svc>`, `nc -z host port`, `curl -fs URL`, `grep <expected> <log>`, `ipcs -m | grep <key>`.
- If the probe fails, re-verify the precondition and report the actual state, not the intended one.
- Test against real scenarios, not just the happy path. If the user has multiple modes (lid open / closed, on Wi-Fi / Ethernet, multiple monitor combos, with / without auth, etc.), run through each before declaring success. A config that works in exactly one scenario is not done.

## Shared Runtime Safety
- Before killing tmux sessions, processes, ports, containers, dev servers, or agents, prove ownership first. Inspect session/window names, commands, cwd, ports, and timestamps; do not rely on numeric tmux session IDs.
- Never run `tmux kill-session -t <number>` or kill broad process groups in a shared workspace. Kill only a specifically named session/process that you created or that the user explicitly identified.
- If stale runtime cleanup might affect other agents or user work, stop and ask before killing it. Prefer starting a uniquely named replacement runtime over terminating ambiguous existing state.

## Sandbox & Permissions
- If the sandbox blocks an action you need to take to complete the user's request, stop and ask for explicit approval -- don't silently work around it with a worse path. State exactly what was blocked, what you'd do if approved, and what the cheaper fallback is. Wait for the user to say "go".
- Same when a tool denies an action mid-task. Don't quietly switch to a degraded approach; flag the gap so the user can either approve the original or accept the degraded one knowingly.

## Tools & Sub-agents
- For codebase exploration that needs more than ~3 searches (where is X used, how does Y work, find all callers of Z), dispatch the `Explore` sub-agent instead of running many `rg`/`fd` calls on the main thread. Keeps context clean and lets me focus on decisions.
- For multi-step independent investigations (log triage by symptom class, parallel "find X in repo A and Y in repo B"), dispatch parallel sub-agents in one message rather than serializing on the main thread.
- For a single known target (a specific file path, a specific symbol), use `Read`/`rg` directly -- don't dispatch a sub-agent.

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
- When you discover existing state that conflicts with the planned change (saved configs, accumulated history, side-effect-bearing files), flag it before the edit, not after the breakage.

## Code style
- Prefer return values over mutable-ref side effects. Reduce global/class state.
- Explicit parameters, no hidden defaults.
- Doxygen in headers only, not in .cpp files.
- Consider performance implications of changes.
- Prefer standard library over custom abstractions.
- Minimum code that solves the problem -- nothing speculative. No features, abstractions, "flexibility", or error handling for impossible scenarios beyond what was asked.
