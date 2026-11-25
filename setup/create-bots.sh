#!/usr/bin/env bash
# Print the specialist proposals. Run from Captain's chat after Captain exists.
# Nothing is created until the owner presses "Create bot" on each card.
# Then: `bash setup/sync.sh adopt && bash setup/sync.sh apply` installs the SOULs from roles/.
set -euo pipefail
ORCA="${ORCA_CLI_COMMAND:-/Applications/Orca.app/Contents/Resources/bin/orca}"

offer() { printf '%s bot create --offer --name %q --purpose %q --json\n\n' "$ORCA" "$1" "$2"; }

offer Reviewer "Merge and code-quality gate: review PRs and worker PRs against the owner's code rules; verdict to Captain."
offer Auditor "Audit the running product for what a PR changes: technical behavior and UI/UX, with evidence; verdict to Captain."
offer "Release Manager" "Run the weekly prod release: what ships, deploy order, post-deploy checks, drafts to Captain."
offer "Flags Cleaner" "Keep the owner's Unleash flags clean: ticket links, cleanup of fully-on flags, ticket drafts to Captain."
offer Oncaller "Investigate threads, bugs and alerts in code and observability; draft answers and the oncall summary for Captain."
offer Scribe "Write the owner's daily standup and periodic contributions page; drafts to Captain."
offer Toolsmith "Watch how the owner works and propose up to 3 concrete workflow improvements a week to Captain."
