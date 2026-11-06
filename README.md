<p align="center">
  <picture><source media="(prefers-color-scheme: dark)" srcset="https://global.media.stux.group/logo-light.png"><source media="(prefers-color-scheme: light)" srcset="https://global.media.stux.group/logo-dark.png"><img src="https://global.media.stux.group/logo-dark.png" height="100" alt="Stux.Group Logo"></picture>
</p>

# stuxgroup.github.io

Stux.Group's GitHub Pages site. It has one job: anyone who visits [stuxgroup.github.io](https://stuxgroup.github.io) is sent straight to the [StuxGroup organization on GitHub](https://github.com/StuxGroup).

Want the same for your own `username.github.io`? Use the reusable template, [GitHub Pages Redirect](https://github.com/StuxGroup/GitHubPagesRedirect), which forwards to your custom domain and keeps the path.

## How it works

`index.html` is a minimal page with a meta refresh and a canonical link to `https://github.com/StuxGroup`, so the redirect is immediate and needs no JavaScript.

`.github/workflows/pages.yml` deploys it to GitHub Pages through Actions whenever `main` changes (or when run by hand), rather than relying on the legacy branch build.

## Changing the target

Edit both URLs in `index.html`:

```html
<meta http-equiv="refresh" content="0;url=https://github.com/StuxGroup" />
<link rel="canonical" href="https://github.com/StuxGroup" />
```

## Versioning

This repo follows [Date Versioning](https://datevers.ing): each version is the UTC release date as `YY.MM.DD` (for example `26.10.23`), with `-1`, `-2`... for later releases the same day. The current version is in [`VERSION.md`](VERSION.md) and every release is described in [`CHANGELOG.md`](CHANGELOG.md). Versions up to v1.0.1 used Semantic Versioning.

Releases are committed and tagged on the `test` branch and go live when the pull request from `test` into `main` is merged; see [Branches](CONTRIBUTING.md#branches).

## Branches

Work happens on `test` (or a branch off it), never on `main`. Changes reach `main`, and the live redirect, only through a pull request from `test`; the release commit and tag are made on `test`. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Copyright © Stux.Group. All rights reserved.

---

Made by [Stux.Group](https://github.com/StuxGroup)

*Stux.Group is the parent of the Stux.Group Brand of Companies: [Stuxedo](https://github.com/Stuxedo), [Stux.Dev](https://github.com/StuxDev), [Stux.Cloud](https://github.com/StuxCloud), [StuxAPIs](https://github.com/StuxAPIs), [Stux.Music](https://github.com/StuxMusic), [Stux.Digital](https://github.com/StuxDigital), [Stux.Design](https://github.com/StuxDesign) and [Stux.Games](https://github.com/StuxGames).*
