# Digest

The digest is the product. Most people will read only the top three lines, so those carry the most important news. Keep it short, factual and easy to skim.

## Format

```
Recon · week of 9 Nov 2026 · 4 competitors watched

The headline: <the single most important change, in one sentence>

High
• Rival: Pro plan up from £49 to £59 a month. Starter unchanged.
  Read: first price rise we've seen, a month after their Workflows AI launch.
  rival.com/pricing · seen 9 Nov
• Other Co: new page comparing themselves to <your company>.
  othercoapp.com/vs/acme · seen 9 Nov

Medium
• Rival: hiring their first Head of Partnerships, and 3 roles in Berlin (new location).
  jobs.ashbyhq.com/rival · seen 9 Nov
• ...

Quiet this week: Third Ltd (no changes)

Couldn't read: Fourth Inc pricing (blocked by the site)
+5 low-importance changes in recon/snapshots/
```

- **The headline** is one sentence, written for someone who reads nothing else.
- Group by importance, not by competitor.
- Shorten URLs for display (drop `https://` and `www.`), but keep them complete enough to open.
- Dates are day and month in the user's locale (British English by default: "9 Nov").
- If nothing changed anywhere, say so in one line. Don't pad it.

## Baseline (first run)

```
Recon · baseline · 9 Nov 2026 · 4 competitors

From next week this will show only what changed. Here's where everyone stands today.

Rival · rival.com
  Positioning: "<headline>"
  Pricing: Starter £29 · Pro £49 (most popular) · Enterprise on request · 14-day trial
  Shipping: 3 changelog entries in the last 30 days, latest "Workflows AI" (4 Nov)
  Hiring: 23 open roles, mostly Engineering (9) and Sales (6), in London, New York and Berlin
...
```

## Where it goes

1. **Always** save it as `recon/digests/<YYYY-MM-DD>.md`.
2. **Slack, if configured:** post it to the configured channel with the Slack connector, as one message. Use Slack formatting (`*bold*` for the headline and section names, `•` bullets, links as `<url|label>`). If the message is over about 3,000 characters, post the High section in the message and the rest as a thread reply.
   - If `slack_auto_post` isn't `yes`, show the user the digest and ask before posting. A scheduled run with no yes saves the file and stops.
   - Before the first post to a channel, read its description and topic. If it says messages like this belong elsewhere, tell the user instead of posting.
3. Show the user the digest in the conversation, and the file path.

## Tone

Plain, specific and calm. No hype ("game-changer", "huge move"), no exclamation marks, no emoji beyond the bullets. Let the facts be interesting.
