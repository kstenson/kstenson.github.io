# kstenson.github.io

My personal site — a homepage plus notes published from my Obsidian vault.
Built with [Quartz v5](https://quartz.jzhao.xyz/) and deployed to GitHub Pages
via GitHub Actions on every push to `main`.

Served at <https://kstenson.github.io/> (and <https://stenson.dev/> once the
custom domain is attached).

## How publishing works

Notes authored in a local folder are mirrored into `content/` (folder
structure preserved), committed, and pushed; GitHub Actions then rebuilds and
deploys.

Set the source folder once in an untracked `.publish.env` file:

```sh
echo 'VAULT_PUBLISH_DIR=/path/to/your/publish/folder' > .publish.env
```

Then publish with:

```sh
./publish.sh
```

The homepage (`content/index.md`) is repo-managed and is **not** overwritten by
publishing (it's excluded from the sync).

## Local preview

```sh
npm install
npx quartz build --serve   # http://localhost:8080
```

## Notes

- Wikilinks (`[[note]]`), backlinks, graph, and search all work across
  published notes.
- Config lives in `quartz.config.yaml`.
