# Orca bots

Canonical, project-agnostic setup for a small fleet of Orca bots that take over any app project — one repo, many, or a local folder — with the owner talking to a single bot. Owner-agnostic: anyone can use it. Everything personal (style, rules, projects, schedules, sensitive actions) lives in one local `OWNER.md`, never in this repo. **No secrets or tokens.**

## Install

1. In Orca, create a bot named **Captain** (Bots sidebar).
2. In Captain's chat: **"install orca-bots from https://github.com/jdflament-sm/orca-bots"**.

Captain clones the repo, runs `setup/install.sh`, fills your `OWNER.md` (asking only what it can't find), proposes the specialists that fit your work, and shows a **Create bot** card for each. Press them; Captain finishes the sync and schedules.

Manual install:

```bash
git clone https://github.com/jdflament-sm/orca-bots ~/orca-bots
bash ~/orca-bots/setup/install.sh          # skills, owner profile, bot SOULs
$EDITOR ~/.config/orca-bots/OWNER.md       # your style, rules, projects, schedules
bash ~/orca-bots/setup/create-bots.sh      # prints one offer per bot: run the ones you want in Captain's chat
bash ~/orca-bots/setup/install.sh          # again, once the bots exist
```

Update later: tell Captain "update the bots" (`git pull` + `setup/install.sh`).

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
| `ob-captain`, `ob-onboard`, `ob-setup` | Captain |
| `ob-work` | Workers |
| `ob-review`, `ob-quality` | Reviewer |
| `ob-experience` | Auditor |
| `ob-docs` | Workers for docs edits |

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

## Maintenance

- **Weekly:** `sync.sh check`, skill usage, automation run history.
- **Monthly:** verify Orca templates and CLI flags after updates.
- **Never:** changes to this repo without a PR the owner approves.

## License

MIT. See [LICENSE](LICENSE).

## Avatars

One Pokémon per role, picked for what the bot does. Upload `assets/avatars/<role>.png` in each bot's settings (Orca has no CLI for avatars). Artwork © Nintendo / Game Freak / The Pokémon Company; internal use only.

| Role | Pokémon | Why |
| --- | --- | --- |
| Captain | Snorlax | Calm and unshakable: blocks the path until the work is done |
| Reviewer | Alakazam | Genius that spots every flaw |
| Auditor | Smeargle | The painter: judges the UI |
| Release Manager | Pikachu | Fast and full of energy: ships releases |
| Flags Cleaner | Muk | Eats waste: swallows dead flags |
| Oncaller | Lucario | Reads aura to find what's hidden |
| Scribe | Unown | Made of letters: writes the standups |
| Toolsmith | Machamp | Four arms, any job: builds the tools |
