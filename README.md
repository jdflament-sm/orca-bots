# Orca bots

Canonical, project-agnostic setup for a small fleet of Orca bots that take over any app project — one repo, many, or a local folder — with the owner talking to a single bot. Owner-agnostic: anyone can use it. Everything personal (style, rules, projects, schedules, sensitive actions) lives in one local `OWNER.md`, never in this repo. **No secrets or tokens.**

## Fleet

| Bot | Job | Writes |
| --- | --- | --- |
| **Captain** | The owner's only contact. Splits work, dispatches workers and bots, verifies, puts decisions on items. | Per the autonomy ladder |
| **Reviewer** | Merge gate and code-quality gate on every worker PR; scheduled PR reviews and comment triage. | Comment reviews only |
| **Auditor** | Audits the running product for what a PR changes: technical + UI/UX, PR screenshots. | Nothing |
| **Release Manager** | Team releases: scope, deploy order, post-deploy checks, drafts. | Nothing without a go |
| **Flags Cleaner** | The owner's feature flags: ticket links, cleanup of fully-on flags, ticket drafts. | Nothing without a go |
| **Oncaller** | Investigates threads, bugs and alerts; drafts answers; weekly oncall summary. | Nothing |
| **Scribe** | Daily standup and periodic reports. | Only pages listed in `OWNER.md` |
| **Toolsmith** | Up to 3 workflow improvements a week, each with a ready PR. | Nothing without a go |
| *Workers* | Short-lived agents Captain starts per task, each in its own worktree (`ob-work`). | Own branch + PR |

The owner only talks to Captain; specialists only talk to Captain. Pick the specialists you need: Captain + Reviewer is a valid fleet.

Workers are not bots: they cost nothing when idle and run in parallel up to the project's cap.

## Principles

1. This repo is the only source of truth for roles, skills and automations. It knows no project: Captain onboards each one itself (`ob-onboard`) and keeps a private profile in its own memory.
2. The owner talks to Captain only. Captain fans work out in parallel and brings back one report per topic.
3. Bots act on their own inside the **autonomy ladder** (`skills/ob-conventions`): *Act*, *Act + tell*, *Ask*. Only *Ask* items interrupt the owner, batched, one word to answer.
4. Never overwrite text or code; additive edits and marker blocks only.
5. Answers are short: 2–4 sentences, ≤5 bullets, `file:line` citations, fixed report shape, one-line verdict from specialists.
6. Every bot and worker runs on Claude. Behavior lives in skills and SOULs, not the agent.

## Layout

| Path | Purpose |
| --- | --- |
| `roles/<role>/SOUL.md` | Canonical SOUL per bot |
| `skills/` | Agent-agnostic `ob-*` skills, installable from this repo |
| `templates/` | `OWNER.md` (the owner profile every bot reads) and an optional `AGENTS.md` marker block |
| `automations/` | Event and schedule automations, all waking Captain |
| `setup/` | Sync, bot proposals, agent switch, bootstrap checklist, validator |

## Skills

| Skill | Loaded by |
| --- | --- |
| `ob-conventions`, `ob-context` | Everyone |
| `ob-captain`, `ob-onboard` | Captain |
| `ob-work` | Workers |
| `ob-review`, `ob-quality` | Reviewer |
| `ob-experience` | Auditor |
| `ob-docs` | Workers for docs edits |

## Quick start

1. Copy `templates/OWNER.md` to `~/.config/orca-bots/OWNER.md` and fill it in. If a bot folder name differs from its role, add `role=folder` lines to `~/.config/orca-bots/folders`.
2. Create Captain manually in the Bots sidebar.
3. From Captain's chat, `bash setup/create-bots.sh` → run each printed command → **Create bot** for each specialist.
4. Install skills:
   `npx skills add https://github.com/jdflament-sm/orca-bots --skill ob-conventions --skill ob-context --skill ob-captain --skill ob-onboard --skill ob-work --skill ob-review --skill ob-quality --skill ob-experience --skill ob-issues --skill ob-docs --global`
5. Hand Captain a project: "take over owner/repo" (or several repos, or a folder). It discovers stack, commands, CI, merge rules and labels, then asks a few one-word policy questions.
6. `bash setup/sync.sh adopt && bash setup/sync.sh apply` installs each SOUL and your `OWNER.md`.
7. Finish `setup/bootstrap.md`.

## Ownership

| Target | Rule |
| --- | --- |
| Bot `SOUL.md`, skills, automation recipes | Managed from this repo |
| Project profiles | Captain's private `memory/projects/`, never in this repo |
| Project `AGENTS.md` / `CLAUDE.md` | Only the marked block is managed; all other text untouched |
| Bot `bot.json`, `AGENTS.md`, `CLAUDE.md`, chats, `MEMORY.md` | Never written by sync |
| Application code | Worker worktree → PR → Reviewer verdict → merge under the owner's per-project authorization |

`sync.sh` uses a three-way hash guard: it updates a file only when the local copy still matches the last applied version. Diverged files are skipped, backed up as `*.orca-bots.conflict`, and reported.

## Token policy

- Claude everywhere. Model tier per job: small for triage, rebases, CI re-runs, docs; strong for risky review and hard bugs.
- Idle specialists cost nothing: no Look around on specialists; Captain at most daily. Memory upkeep weekly or off.
- Events over schedules; every schedule has a `--precheck` so it skips when nothing changed.
- Handoffs carry a brief and paths, never pasted files. One combined reply per bot, even when it fanned out to subagents.
- Worker cap per project (default 3); stalled workers are stopped, not left burning.
- Install `brodesigns.skill-usage`; prune unused skills monthly.

## Coordinator

Captain alone carries this rule:

> If the orca-coordinator plugin is present, keep its board current; if absent, ignore it — it is optional.

## Maintenance

- **Weekly:** `sync.sh check`, skill usage, automation run history.
- **Monthly:** verify Orca templates and CLI flags after updates.
- **Never:** changes to this repo without a PR the owner approves.

## License

MIT. See [LICENSE](LICENSE).
