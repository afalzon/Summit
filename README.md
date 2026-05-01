# Summit

## Important Project Annoucement

Sorry everyone, I have moved to Scotland and as such dont have proper access anymore to Terrain to further develop summit. I am happy to hand over access to the code if someone is interested in taking over the project. Please reach out if this if of interest.

## Summary

This tool is to help provide usability features to the Scouts | Terrain website. Feel free to let us know about any issues or request new features in the issues tab.

To get started install the add on for your browser below:

[![Chome Logo](https://github.com/pete-mc/Summit/wiki/images/chrome.png)](https://chromewebstore.google.com/detail/terrain-summit/fkpdafjknodpembpmogbcblabonpmhoo?hl=en&pli=1) [![Edge Logo](https://github.com/pete-mc/Summit/wiki/images/edge.png)](https://microsoftedge.microsoft.com/addons/detail/terrain-summit/eoemenakogcfmmhkoiejhefmdijgpgnb)

[![Build and Release Chrome Extension](https://github.com/pete-mc/Summit/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/pete-mc/Summit/actions/workflows/build.yaml)

## Pull request quality gate

- Unit tests run on pull requests targeting `main` via `.github/workflows/build.yaml`.
- Configure branch protection (or a ruleset) on `main` to require the `Build / test` status check before merge.

## Unit testing conventions

- Centralized test folders:
  - `tests/unit/helpers`
  - `tests/unit/models`
  - `tests/unit/services`
  - `tests/unit/smoke`
- Naming convention:
  - Use `*.spec.ts` for unit tests.
  - Name files to mirror source behavior (for example: `CompressGuids.spec.ts`, `fetchActivity.spec.ts`).
- Mock strategy:
  - Keep mocks local to the test where possible for readability.
  - Reuse shared service mocks via `tests/unit/services/mocks/*` when multiple tests require the same setup.
  - Mock external/runtime boundaries (network, Terrain host/runtime globals), not pure helper/model logic.

## Test and coverage behavior in CI

- Pull requests must pass tests (`npm test`) before merge.
- Coverage (`npm run test:coverage`) is informational only and is used for visibility/tracking.
- No hard coverage threshold is enforced in Jest/CI, so coverage does not block merges by itself.

## Browser layout tests

`npm run test:browser` runs Playwright browser-level layout tests. Fresh environments may need to install Chromium first with `npx playwright install chromium`.

## Local build

You can build Summit locally with the bundled npm scripts.

1. Install dependencies with `npm ci`.
2. Run `npm run build` for a development build.
3. Run `npm run build-prod` for a production build.
4. Run the `Package Summit extension artifact` VS Code task to produce a zip archive for distribution.

The output is written to `dist/`.

Packaged artifacts are written to `artifacts/Summit.zip`.

### Local development server

Run `npm start` to launch the local webpack dev server.

- It serves over HTTPS using the certificates in `certs/`.
- It binds to `https://localhost:443`.
- On Windows, port `443` may require elevated privileges or may already be in use.

### VS Code tasks

This repository includes VS Code tasks for dependency install, development build, production build, packaging the extension artifact, watch mode, and starting the local dev server.

## Chromium build workflow (Brave/Chrome/Edge)

Use this workflow if you want to maintain Summit and publish/test a Chromium build from your laptop or NAS worker.

1. Install dependencies:
  - `npm ci`
2. Create production Chromium build:
  - `npm run build:chromium`
3. Package distributable zip:
  - `npm run package:chromium`

If Node is not installed locally, run the Docker helper script instead:
- `./scripts/build-chromium-docker.sh`

Build output paths:
- Unpacked extension: `dist/`
- Packaged zip artifact: `artifacts/Summit-chromium.zip`

### Load in Brave (local testing)

1. Open `brave://extensions`.
2. Enable **Developer mode**.
3. Click **Load unpacked**.
4. Select the `dist/` folder from this repo.
5. Open Terrain and verify Summit menu/routes render.

### Suggested CI/worker pattern

For reproducible releases from your NAS worker or GitHub Actions:

1. On push to your maintenance branch, run:
  - `npm ci`
  - `npm test`
  - `npm run package:chromium`
2. Publish `artifacts/Summit-chromium.zip` as a build artifact.

This keeps local development fast while ensuring release artifacts are always built in a clean environment.

## Firefox build workflow

Use this workflow to generate a Firefox-compatible package from the same source.

1. Build Firefox variant:
  - `npm run build:firefox`
2. Package Firefox artifact:
  - `npm run package:firefox`

If Node is not installed locally, run the Docker helper script instead:
- `./scripts/build-firefox-docker.sh`

Build output paths:
- Unpacked extension: `dist/` (with Firefox manifest applied)
- Packaged zip artifact: `artifacts/Summit-firefox.zip`

### Load in Firefox (local testing)

1. Open `about:debugging`.
2. Select **This Firefox**.
3. Click **Load Temporary Add-on...**.
4. Choose the generated `dist/manifest.json` file.
5. Open Terrain and verify Summit menu/routes render.

Note: temporary add-ons are removed when Firefox closes. For persistent distribution, the extension needs normal Firefox signing/publishing.

## Examples

A few of the features are showcased below. [Visit the Wiki to see the full list of features and how-to guides](https://github.com/pete-mc/Summit/wiki).

## Peak Award Progress Report

User friendly single page report to see where each of the youth members are traveling on the peak award journey.
![Peak Award](https://github.com/pete-mc/Summit/wiki/images/peak-award.png)

## OAS Report

This report will give you a nice summary of the OAS levels each youth member is at and the related streams. This is a nice one pager to help you see where all the members of your unit are up to.
![OAS Report](https://github.com/pete-mc/Summit/wiki/images/oas-report.png)

## Bulk Calendar Entry Form

This is to help you submit a full term or more of activities to your plan. It simplifies the process by only asking the basic questions and you can enter many on a single page.
![Bulk Calendar Tool](https://github.com/pete-mc/Summit/wiki/images/bulk-events.png)

## Export events to your own calendar

Sick of adding events in Terrain and also your own calendar. Use the shiny new button contained in a planned activity and you will recieve a ical file ready to be imported into whichever calendar application you use.
![Export Events](https://github.com/pete-mc/Summit/wiki/images/save-calendar.png)
