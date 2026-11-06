---
name: competitor-recon
description: Watch competitors' public websites and report only what changed, as a short weekly digest with evidence. Tracks pricing pages, homepage messaging, changelogs and blogs, new and removed pages (from sitemaps) and hiring (from public job boards), saves dated snapshots, diffs each run against the last, drops the noise, and ranks what's left by how much it matters. Can post the digest to Slack. Use this skill whenever the user wants to track or monitor competitors, see what a competitor changed or launched, watch a rival's pricing, see who competitors are hiring, get a competitor digest or "what's new with X", or set up weekly competitive intelligence, even if they do not say "recon".
---

# Recon

Competitors in, a short digest of what actually changed out. The first run takes a baseline. Every run after that compares against the last snapshot and reports only real changes, each with its source and date.

**The core rule: public pages only, and every claim has evidence.** Recon reads what any visitor could read, politely, and never signs in, bypasses a block or collects personal data. Every line in a digest links the page it came from and says when it was seen.

## Where things live

- **Skill files** (this folder): process, formats and scripts. Read-only during a run.
- **Workspace** (the user's current directory, folder `recon/`):
  - `recon/config.md`: the user's company, competitors and the sources for each, what they care about, and where the digest goes. Created on first run from `templates/config.template.md` (`references/setup.md`).
  - `recon/snapshots/<competitor>/<source>/<YYYY-MM-DD>.md`: what each source looked like on each run. Kept, never edited, so any change can be traced.
  - `recon/digests/<YYYY-MM-DD>.md`: each digest as sent.

## The run

Keep the user informed with one short line per step.

| # | Step | Read | Gate |
|---|---|---|---|
| 0 | Setup: if `recon/config.md` doesn't exist, or the user wants to add or change competitors | `references/setup.md` | **Confirm the competitor list and sources** |
| 1 | Collect: one parallel agent per competitor, each fetching that competitor's sources and saving today's snapshots | `references/sources.md`, `references/rules.md` | |
| 2 | Diff: compare each snapshot with the previous one, drop noise, turn real changes into signals and rank them | `references/diffing.md` | |
| 3 | Digest: write it, save it, and send it where config says | `references/digest.md` | **First Slack post to a channel needs a yes** |

Read `references/rules.md` once at the start of every run. It is short and every agent must follow it.

**First run.** There is nothing to compare yet, so step 2 is skipped and step 3 writes a **baseline** instead: each competitor's current pricing, positioning, recent posts and hiring, in one page. Say clearly that changes start appearing from the next run.

**Same-day reruns.** If today's snapshot already exists for a source, compare against the one before it and overwrite today's, so a rerun never reports zero changes.

## Parallel collection

Start one agent per competitor, in one message, so they run at the same time. Give each one: the competitor's block from `recon/config.md`, today's date, the snapshot folder path, and the full text of `references/sources.md` and `references/rules.md`. Each agent saves its snapshots and returns a one-line status per source: `saved`, `unchanged`, `blocked (<reason>)` or `not found`. Blocked and not-found sources go in the digest's footer, not as errors.

## Running it every week

The digest is most useful on a schedule. After the first successful run, offer one of these, in one line:

- **Run it yourself:** say "run recon" every Monday.
- **Schedule it:** set up a recurring routine (the `schedule` skill, or `/loop` in a long-running session). Snapshots must stay where the routine can read them, so for cloud routines keep `recon/` in a private git repo that the routine clones and commits back to.

## Things the user can say

- "run recon" / "what did competitors change this week?": a full run.
- "what's new with <competitor>?": a run for that competitor only.
- "add <competitor>" / "stop watching <competitor>": update config through `setup.md`.
- "show <competitor>'s pricing history": read the pricing snapshots in date order and summarise each change.
