# Rules for every run

Every agent in every run follows these. They keep Recon legal, polite and trustworthy.

## What may be read

- **Public pages only.** Anything a logged-out visitor can see. Never sign in, use someone's account or cookies, or read anything behind a paywall, a demo request form or a customer portal.
- **Respect robots.txt.** Before fetching a path on a site, check `https://<domain>/robots.txt`. If the path is disallowed for all user agents (`User-agent: *`), skip it and report `blocked (robots.txt)`.
- **Don't get around blocks.** If a site returns a challenge page, a 403 or a "please verify you're human" page, stop and report `blocked (<status or reason>)`. Don't retry with other user agents, proxies or headless tricks.
- **Be gentle.** One request at a time per site, at least a second apart, and only the pages named in config, plus the sitemap and RSS feeds. Never crawl a whole site.
- **Official job boards only.** Use the company's own careers page or its public applicant-tracking API (`scripts/jobs.sh`). Don't scrape LinkedIn, Glassdoor or other sites whose terms forbid it.
- **Review sites** (G2, Capterra, Trustpilot): read the competitor's public review summary page only if it loads normally. Never bulk-download reviews.

## What may be kept

- **No personal data.** Don't save names, photos or contact details of a competitor's employees, customers or reviewers. Job titles, departments and locations of roles are fine. Hiring managers' names are not.
- **Snapshots are text.** Save the cleaned text that matters (see `sources.md`), not raw HTML or images.

## How to report

- **Every signal has evidence:** the page URL and the date it was seen, and for changes, the old and new value.
- **Facts and interpretation stay separate.** "Pro went from £49 to £59 a month" is a fact. "Likely testing price sensitivity before a launch" is an interpretation and must be labelled as one ("Read:" in the digest).
- **Never invent.** If a page couldn't be read, say so. Don't fill the gap from memory or guesswork.
