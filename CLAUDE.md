# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Quarto-based course website** for IAFF 6501 (Quantitative Analysis for IA Practitioners) at George Washington University. The course teaches R programming, data visualization, statistical inference, and modeling for international affairs students.

**Primary Website**: https://dataviz-gwu.rocks (built from https://quarto4ia.rocks)

## Technology Stack

- **Quarto**: Website builder and document renderer
- **R/RStudio**: Primary programming language and IDE
- **R Packages**: tidyverse (dplyr, ggplot2, readr, tidyr), vdemdata, leaflet, unvotes, lubridate, scales, and others
- **Quarto Extensions**: Located in `_extensions/coatless/`

## Common Commands

### Building and Previewing

```bash
# Preview the website locally with live reload
quarto preview

# Render the entire website
quarto render

# Render a single document
quarto render path/to/file.qmd

# Render to specific format
quarto render file.qmd --to html
quarto render file.qmd --to pdf

# Publish to configured destination
quarto publish
```

### Development Workflow

```bash
# Check Quarto version
quarto --version

# Install/update Quarto extensions
# (Extensions are in _extensions/ directory)
```

## Repository Structure

### Content Organization

The repository follows a modular structure with three parallel content hierarchies:

1. **`modules/`** - Detailed learning modules with code examples and exercises
2. **`slides/`** - Reveal.js presentations corresponding to each module (named `week-X.Y.qmd`)
3. **`weeks/`** - Weekly landing pages that aggregate readings, videos, and links

### Key Directories

- **`assignments/`** - Homework assignments (homework-1.qmd, homework-2.qmd, homework-3.qmd)
- **`project/`** - Final project description and dataset information
- **`images/`** - Course images and logo files
- **`modules/data/`** - CSV data files used in modules (dem_data.csv, wb_data_clean.csv, etc.)
- **`modules/functions/`** - Reusable R functions (helper.R, wb-maps.R)
- **`slides/data/`** - Data files used in slides
- **`_site/`** - Generated website output (gitignored)
- **`_freeze/`** - Quarto freeze cache for faster rebuilds
- **`.quarto/`** - Quarto project cache

### Course Page Structure

- **`index.qmd`** - Main course schedule page (uses helper.R for date calculations)
- **`course-syllabus.qmd`** - Complete course syllabus
- **`course-support.qmd`** - Support resources
- **`course-links.qmd`** - Useful external links
- **`instructor.qmd`** - Instructor information

## Key Configuration Files

### `_quarto.yml`

The main Quarto project configuration file:
- Website metadata (title, description, URLs)
- Navigation sidebar structure
- Theme settings (cosmo/cyborg for light/dark modes)
- Font: "Atkinson Hyperlegible"
- Output format settings

### `helper.R`

Date calculation utilities used in index.qmd:
- Defines semester start date (`mon` and `tues` variables)
- `advdate()` function: calculates dates for course schedule
- `advdate2()` function: formats dates with day names

When updating the semester, change the start date in helper.R:
```r
mon <- as_date("2026-01-12")  # Update this for new semester
```

## Content Patterns

### Module Files (modules/*.qmd)

Standard structure:
```yaml
---
title: "Module X.Y"
subtitle: "Topic Name"
format: html
execute:
  echo: true
  message: false
  warning: false
---
```

Modules typically include:
- Embedded videos using `{{< video URL title='Title' >}}`
- Code chunks with `#| label:` syntax
- Callout blocks for tips and notes: `::: {.callout-tip}`
- R code examples using tidyverse patterns
- Links to external resources and documentation

### Slide Files (slides/*.qmd)

Reveal.js presentations with standard YAML:
```yaml
---
title: "Course Title"
subtitle: "IAFF 6501"
footer: "[IAFF 6501 Website](https://quant4ia.rocks)"
logo: images/iaff6501-logo.png
format:
  revealjs:
    theme: [simple, custom.scss]
    transition: fade
    slide-number: true
    chalkboard: true
execute:
  echo: false
  message: false
  warning: false
  freeze: auto
---
```

Slides use:
- `##` for slide titles
- Incremental lists: `::: incremental`
- Timer widgets from countdown package
- Custom styling from `slides/custom.scss`

### Assignment Files (assignments/*.qmd)

Homework assignments follow a step-by-step structure:
- Overview with context and academic references
- Numbered steps with point values (e.g., "Step 1: Gather your data (20 pts)")
- Instructions in italics for students to complete
- Bonus questions for extra credit
- Submission instructions in callout blocks

## Data Science Workflow Patterns

### V-Dem Data Pattern

Common pattern for downloading and filtering V-Dem democracy data:
```r
library(vdemdata)
democracy <- vdem |>
  filter(year >= 1990) |>
  select(
    country = country_name,
    vdem_ctry_id = country_id,
    year,
    polyarchy = v2x_polyarchy,
    gdp_pc = e_gdppc,
    region = e_regionpol_6C
  ) |>
  mutate(
    region = case_match(region,
      1 ~ "Eastern Europe",
      2 ~ "Latin America",
      3 ~ "Middle East",
      4 ~ "Africa",
      5 ~ "The West",
      6 ~ "Asia")
  )
```

### Visualization Patterns

Standard ggplot2 patterns used throughout:
- Color-blind friendly palettes: viridis, manual scales
- Theme: `theme_minimal()` is preferred
- Proper labeling with `labs()` or `xlab()`/`ylab()`/`ggtitle()`
- Custom color palette: `cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")`

## Development Guidelines

### When Editing Content

1. **Modules and Slides**: Check if there's a corresponding slide deck when editing modules
2. **Schedule Updates**: Remember to update `helper.R` for new semester dates
3. **Data Files**: Module-specific data files are in `modules/data/`, shared data in `slides/data/`
4. **Links**: Internal links use relative paths (e.g., `/modules/module-1.1.html`)
5. **Videos**: Embedded using Quarto video shortcode, hosted on YouTube

### When Adding New Content

1. Follow the naming convention: `module-X.Y.qmd` or `week-X.Y.qmd`
2. Add new pages to `_quarto.yml` sidebar navigation
3. Update the schedule in `index.qmd` with appropriate links
4. Store reusable functions in `modules/functions/`
5. Place data files in appropriate `data/` subdirectories

### Rendering Behavior

- `freeze: false` in _quarto.yml means code executes on every render
- Individual files can override with `freeze: auto` to cache results
- Slide files typically use `freeze: auto` to speed up rendering
- Clear the `_freeze/` directory if experiencing caching issues

## Course-Specific Context

### Academic Focus

The course emphasizes:
- **Reproducible research** using Quarto
- **Tidy data principles** (tidyverse ecosystem)
- **Policy-relevant analysis** for international affairs
- **Visualization skills** for effective communication
- **Statistical literacy** (inference, modeling, hypothesis testing)
- **Native pipe operator** (`|>`) over magrittr pipe (`%>%`)

### Student Workflow

Students are expected to:
- Use RStudio Desktop with Quarto
- Create project-oriented workflows (no `setwd()`)
- Submit rendered HTML documents to Blackboard
- Optionally publish to Quarto Pub
- Use GitHub Classroom for version control (referenced but not in repo)

### Key Datasets

- **V-Dem**: Democracy indicators, accessed via `vdemdata` package
- **World Bank**: Economic data, cleaned versions in `wb_data_clean.csv`
- **UN Votes**: Voting patterns, from `unvotes` package
- **Custom CSVs**: Pre-processed datasets in `modules/data/`

## Important Notes

- The course website is published to both dataviz-gwu.rocks and quant4ia.rocks
- Repository name references "spring-2024" but is used across multiple semesters
- Helper.R semester start date should be updated for each new term
- Extensions in `_extensions/coatless/` are course-specific customizations
- `.luarc.json` present for Lua language server configuration
