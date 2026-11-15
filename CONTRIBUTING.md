<p align="center">
  <picture><source media="(prefers-color-scheme: dark)" srcset="https://global.media.stux.group/logo-light.png"><source media="(prefers-color-scheme: light)" srcset="https://global.media.stux.group/logo-dark.png"><img src="https://global.media.stux.group/logo-dark.png" height="80" alt="Stux.Group Logo"></picture>
</p>

# Contributing to stuxgroup.github.io

This is a minimal GitHub Pages redirect page (`index.html`) that forwards visitors from `stuxgroup.github.io` to [github.com/StuxGroup](https://github.com/StuxGroup). This document is for anyone working on the redirect page itself.

## Local setup

There's no build step or dependencies — just open `index.html` in a browser, or serve the directory with any static file server, e.g.:

```bash
python3 -m http.server 8000
```

## Project conventions

- Single static `index.html` — no framework, no build step, no backend.
- Keep it minimal; this repo exists only to redirect GitHub Pages traffic.

## Branches and going live

- **`main` is what's live.** Nothing is pushed to it directly: it only changes when a pull request from `staging` is
  merged.
- **`staging` is the last check before live.** It only changes when a pull request from `test` is merged.
- **Work happens on `test`**, or on a feature branch off `test` that's merged back into it. Releases are made on `test`
  too; `commit.sh` / `commit.bat` refuse to run on `staging` or `main`.
- **Going live:** push `test` with its tag (`git push origin test --tags`), open a pull request into staging
  (`gh pr create --base staging --head test`), check staging once it's merged, then open one from staging into main
  (`gh pr create --base main --head staging`). CI runs on both pull requests; Leo reviews and merges them.
- **Deploys:** Merging the pull request into `main` deploys the redirect to GitHub Pages. Merging into `staging` doesn't deploy anything.

## Versioning and changelog

- This repo follows [Date Versioning](https://datevers.ing). The version lives in `VERSION.md` as a bare version string (no `v`): the UTC release date as `YY.MM.DD`, or `YY.MM.DD-N` for the second, third... release on the same UTC day (`-1`, `-2`, ...). Use UTC (`date -u +%y.%m.%d`), not local time: just after midnight in the UK it is still the previous day in UTC. Never use a future date.
- To pick the next version, take today's UTC date; if a `vYY.MM.DD` tag already exists for it, use the next free `-N` (check with `git tag -l "vYY.MM.DD*"`).
- Every release gets a `CHANGELOG.md` entry headed `## vYY.MM.DD`, using `###` subsections in this order: Added, Changed, Fixed, Removed, Security, Deprecated
- `commit.sh` (bash) and `commit.bat` (Windows) read `VERSION.md` to commit and tag a release as `vYY.MM.DD` — no need to edit them per release. They refuse a version that isn't a valid Date Version or is dated in the future (UTC), warn if it's dated before today, and never push (they print the push command instead: `git push origin test --tags`, then open a pull request from `test` into `staging`, and once that's merged and checked, one from `staging` into `main` (see "Branches and going live"))

## Tests

Run the dependency-free test suite with:

```bash
bash tests/run.sh
```

It checks that `VERSION.md` is a valid Date Version on a real calendar date and matches the newest `CHANGELOG.md` entry.

## Before committing

- Run `bash tests/run.sh`
- Open `index.html` in a browser and confirm the redirect fires correctly
