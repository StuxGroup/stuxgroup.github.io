# Changelog

All notable changes to stuxgroup.github.io are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Date Versioning](https://datevers.ing): each version is the UTC release
date as `YY.MM.DD`, with `-1`, `-2`... for later releases the same day. Versions up to v1.0.1 used
Semantic Versioning.

## v26.10.23

### Added
- `tests/run.sh`, a small dependency-free test runner, with a check that `VERSION.md` is a valid Date Version, a real calendar date, and matches the newest `CHANGELOG.md` entry

### Changed
- Switched from Semantic Versioning (last version v1.0.1) to [Date Versioning](https://datevers.ing): versions are now the UTC release date as `YY.MM.DD`, plus `-1`, `-2`... for later releases the same day
- `commit.sh`/`commit.bat` now refuse to release a `VERSION.md` that isn't a valid Date Version or is dated in the future (UTC), and warn when it's dated before today
- `README.md` gained a Versioning section, and `CONTRIBUTING.md`'s versioning notes describe Date Versioning and how to run the tests

## v1.0.1

### Fixed
- GitHub Pages was using the legacy branch-deploy build system, which can silently stop auto-deploying with no error recorded anywhere (discovered on SeasonalOverlaysLibrary — its live site served stale content for over an hour with no visible failure). Switched to GitHub Actions-based Pages deployment (`.github/workflows/pages.yml`), making every deploy an ordinary, observable CI run instead.

## v1.0.0

### Added
- First version-tracked release of this GitHub Pages redirect repo — `VERSION.md`/`CHANGELOG.md`/`CONTRIBUTING.md`/`commit.sh`+`commit.bat` added, following the standard release-flow convention used across other Stux.Group brand repos

### Fixed
- `README.md`'s header logo pointed at a stale `media.stux.group/global/logo.png` host — corrected to `https://global.media.stux.group/logo.png`
