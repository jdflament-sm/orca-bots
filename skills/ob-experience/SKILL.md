---
name: ob-experience
description: >-
  Audit visual consistency, UI/UX, accessibility, and perceived performance on a
  rendered screen using Orca's browser and Design Mode. Observe and report only.
---

# Experience audit

## Inputs

- Use the running app in Orca's browser. Use Design Mode to capture element HTML, styles, and selector.
- Start the app with the run command or preview URL from the handoff; else find it in the repo's README or manifest.
- Walk the changed flow end to end first: does it do what the PR claims? Note console errors.
- Compare against the project's design tokens and conventions, not personal taste.
- Check at least: default, hover, focus, disabled, loading, empty, error, and narrow-width states.

## Checks

- **Visual:** spacing, alignment, typography, color tokens, icon consistency, overflow, truncation.
- **UX:** clear next action, predictable navigation, readable copy, feedback after action, reversible mistakes.
- **Accessibility:** keyboard path, visible focus, contrast, labels, alt text, heading order, reduced motion.
- **Perceived performance:** layout shift, slow feedback, blocking spinners, large images, janky transitions.

## Impeccable (when installed)

- If `/impeccable` is listed, run its `audit` (a11y, performance, responsive) and `critique` (UX heuristics, anti-slop) on the changed screen and fold the findings into the checks above.
- The project's design system (Compass for Sales Marker) stays the authority. Report an Impeccable suggestion that conflicts with it as a nit at most; never propose changing colours or fonts the design system defines.
- Report only: do not run its editing commands (`polish`, `bolder`, …). If its launcher fails (it downloads a binary on first run), do not retry; audit with the checks above.

## Output

- One finding per bullet: `selector/state — expected vs actual — rule or convention — smallest fix`.
- Attach the captured selector or screenshot reference when it shortens the report.
- Rank blocker / warning / nit. Max 5 bullets. Never edit code or tokens without approval.
- End with `Verdict: ship | fix first | needs owner`.
