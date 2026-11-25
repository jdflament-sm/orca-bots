# Bootstrap checklist

Captain does all of this through the `ob-setup` skill; this list is for checking or doing it by hand.

1. **Captain** — create it in Orca's Bots sidebar.
2. **Install** — `bash setup/install.sh` (skills, `~/.config/orca-bots/OWNER.md`, SOULs). Re-run after every `git pull`.
3. **Owner profile** — fill `~/.config/orca-bots/OWNER.md`; renamed bot folders go in `~/.config/orca-bots/folders` as `role=folder`.
4. **Specialists** — `bash setup/create-bots.sh` prints one offer per bot; run the ones you want, press **Create bot**, then `bash setup/install.sh` again.
5. **Agent** — Claude by default; `node setup/set-agent.mjs <agent>` switches the fleet.
6. **Permissions** — allow routine commands; keep push, merge, posts and prod on ask.
7. **Background cost** — Look around off on specialists, Captain at most daily.
8. **Connectors** — code host on Captain and Reviewer; tracker and chat where the bots need them.
9. **Automations** — create only what your bots need from `automations/README.md`, test with `run`, then enable.
