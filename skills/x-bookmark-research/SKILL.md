---
name: X Bookmark Research
description: Transform Twitter/X bookmarks into structured research markdown files with AI-powered analysis
version: 1.0.0
author: Community
license: MIT
---

# X Bookmark Research

A Claude Code skill that transforms your Twitter/X bookmarks into structured, actionable research notes.

## What It Does

When you bookmark interesting tweets, this skill processes them into organized markdown files with:
- **Key insights** extracted from the content
- **Author context** (who they are, why their perspective matters)
- **Personal relevance** connected to your configured interests and projects
- **Action items** so bookmarks become actionable, not forgotten

## Dependencies

### Required

- **[bird CLI](https://github.com/ryo-ma/bird)** - Command-line tool for Twitter/X API access
  - Used to fetch bookmarks, read tweets, and look up author profiles
  - Must be authenticated before first use (`bird auth`)

### Optional

- **Exa MCP Server** - Only needed for `--depth deep` research mode
  - Provides web search for broader context around tweet topics
  - The skill gracefully degrades to `standard` depth without it

## Configuration

This skill reads its settings from `~/.claude/skills/x-bookmark-research/config.yml`.

Copy the example config to get started:

```bash
cp ~/.claude/skills/x-bookmark-research/config.example.yml ~/.claude/skills/x-bookmark-research/config.yml
```

Then edit `config.yml` with your output directory and interests.

## Usage

Invoke via the slash command:

```
/research-bookmarks          # Interactive - asks how many and what depth
/research-bookmarks 5        # Process 5 recent bookmarks
/research-bookmarks all      # Process all unprocessed bookmarks
/research-bookmarks <url>    # Research a specific tweet
/research-bookmarks 10 --depth deep   # 10 bookmarks with web research
```

## References

- `references/output-format.md` - Full output template specification and formatting guidelines
