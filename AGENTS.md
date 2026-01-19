# Repository Guidelines

## Project Structure & Module Organization

- `index.qmd` is the main schedule landing page, with supporting pages like `course-syllabus.qmd` and `course-support.qmd`.
- Core content lives in three parallel trees:
  - `modules/` for detailed learning modules (`module-X.Y.qmd`).
  - `slides/` for Reveal.js decks (`week-X.Y.qmd`) and `slides/custom.scss` for styling.
  - `weeks/` for weekly overview pages.
- Assignments and final project materials are in `assignments/` and `project/`.
- Data lives in `modules/data/` and `slides/data/`. Shared R helpers are in `modules/functions/` and `helper.R`.
- Generated output is in `_site/` and cached renders in `_freeze/` (do not hand-edit).

## Build, Test, and Development Commands

- `quarto preview` launches the live-reload dev server.
- `quarto render` builds the full site; `quarto render path/to/file.qmd` renders a single file.
- `quarto render file.qmd --to html|pdf` targets specific formats.
- `quarto publish` deploys to the configured destination.

## Coding Style & Naming Conventions

- Follow existing `.qmd` structure and YAML headers; use the native R pipe (`|>`) over `%>%`.
- Keep R chunks quiet by default (`message: false`, `warning: false`) and prefer `theme_minimal()` in plots.
- Naming: `module-X.Y.qmd`, `week-X.Y.qmd`, and `homework-N.qmd` for assignments.
- No formal formatter/linter is configured; match surrounding style and spacing.

## Testing Guidelines

- No automated test framework is present. Validate changes by rendering affected files.
- For slides, confirm Reveal.js decks render correctly and links resolve (`quarto render slides/week-X.Y.qmd`).

## Commit & Pull Request Guidelines

- Recent commit messages are short, imperative summaries (e.g., “Update syllabus”, “spring 2026 update”).
- Keep commits scoped to a single content change or update set.
- PRs should include a brief description, linked issues (if any), and screenshots or rendered output notes when visual changes are made.

## Configuration & Content Tips

- `_quarto.yml` defines site navigation and theming; update it when adding new pages.
- `helper.R` controls semester start dates for schedule logic—update it when rolling to a new term.
