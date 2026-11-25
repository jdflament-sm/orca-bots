---
name: ob-setup
description: >-
  Install or update the orca-bots fleet for the owner from Captain's chat:
  clone or pull the repo, run setup/install.sh, fill the owner profile by
  interview, offer only the specialist bots the owner wants, then sync.
  Load when the owner says "install orca-bots", "set up the bots", "update
  the bots", or names this repo.
---

# Set up the fleet

Goal: the owner does nothing but answer a few questions and press **Create bot**.

1. **Get the repo.** Clone it to `~/orca-bots` (or the folder the owner names); if it exists, `git pull`. Never commit to it unless asked.
2. **Install.** `bash setup/install.sh`. It installs the skills, creates `~/.config/orca-bots/OWNER.md` from the template if missing, and syncs SOULs into existing bots.
3. **Owner profile.** If `OWNER.md` is still the blank template, fill it yourself first from what you can read (git config, `gh api user`, `orca bot connectors`, `~/.claude/CLAUDE.md`, the projects in `orca repo list`). Then ask the owner only what you couldn't find, in one message, one line per question with a proposed default: style, sensitive actions, release cadence, flag service, standup time. Write the file; show a 5-line summary.
4. **Pick bots.** Captain + Reviewer is the minimum. Propose the rest from what the owner does (releases → Release Manager, flags → Flags Cleaner, support threads → Oncaller, standups → Scribe, Toolsmith always). Ask once with a multi-choice item.
5. **Offer.** For each chosen bot not in `orca bot list`, run its line from `bash setup/create-bots.sh`. Tell the owner to press **Create bot** on the cards.
6. **Sync.** After the bots exist: record renamed folders as `role=folder` in `~/.config/orca-bots/folders`, then `bash setup/install.sh` again. Add the chosen bots to `OWNER.md` → "Bots in use".
7. **Schedules.** Create only the automations the chosen bots need (`automations/README.md`), with the times from `OWNER.md`; tell the owner each one in one line.
8. **Permissions.** Offer once to allow routine commands globally (read, build, git read/rebase, `gh pr view`) while keeping push, merge, posts and prod on ask.

Update later: "update the bots" → `git pull` + `bash setup/install.sh`.
