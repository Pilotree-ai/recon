# Recon config

Created by Recon's setup. Edit freely, or say "add <competitor>" or "change where the digest goes".

## You

- company: TODO              # e.g. Acme
- website: TODO              # e.g. acme.com
- focus: ""                  # what matters most, e.g. "pricing and anything AI"

## Digest

- destination: file          # file | slack
- slack_channel_id: ""       # e.g. C0123456789, when destination is slack
- slack_channel_name: ""     # e.g. #competitors
- slack_auto_post: no        # yes lets scheduled runs post without asking
- max_signals: 10

## Competitors

One block per competitor. Leave a source empty ("") if it doesn't exist.

### rival
- name: Rival
- domain: rival.com
- pricing: https://rival.com/pricing
- changelog: https://rival.com/changelog
- changelog_feed: ""         # RSS or Atom, if there is one
- blog: https://rival.com/blog
- blog_feed: https://rival.com/blog/rss.xml
- sitemap: yes               # yes | no
- jobs: ashby rival          # <greenhouse|lever|ashby|workable> <slug>, or a careers page URL, or ""
- extra:                     # optional extra pages to watch
  - https://rival.com/integrations
