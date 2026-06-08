# kstenson.github.io

My personal homepage — a short intro, links to the things I've built, and a
minimal blog. Served at <https://kstenson.github.io/> (and, once the custom
domain is attached, <https://stenson.dev/>).

Built with [Jekyll](https://jekyllrb.com/) and deployed automatically by
GitHub Pages from the `main` branch — no Action or build step to manage.

## Local development

Ruby is pinned via [mise](https://mise.jdx.dev/) (`mise.toml`).

```sh
mise install          # installs Ruby 3.3.6
bundle install        # installs Jekyll + plugins
bundle exec jekyll serve   # http://localhost:4000
```

## Adding a blog post

Drop a Markdown file in `_posts/` named `YYYY-MM-DD-slug.md` with front matter:

```markdown
---
layout: post
title: "Your title"
date: 2026-06-08
---

Post body…
```

## Adding / editing projects

The homepage project list is data-driven — edit the `projects:` block in
`_config.yml`, not the HTML.
