# X Bookmark Research

A Claude Code extension that transforms your Twitter/X bookmarks into structured, actionable research notes.

Stop losing insights in your bookmark graveyard. This slash command fetches your bookmarks via the `bird` CLI, analyzes them with Claude, and writes organized markdown files with key insights, author context, and action items tied to your personal interests.

## Prerequisites

- **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)** - Anthropic's CLI for Claude
- **[bird CLI](https://github.com/steipete/bird)** - Twitter/X API client (`npm install -g @steipete/bird`)
- **Exa MCP Server** *(optional)* - Only needed for `--depth deep` web research mode

## Installation

### Option 1: Install Script

```bash
git clone https://github.com/matthewod11-stack/X-bookmark-research.git
cd X-bookmark-research
./install.sh
```

### Option 2: Manual Copy

```bash
# Copy the slash command
cp commands/research-bookmarks.md ~/.claude/commands/

# Copy the skill
cp -r skills/x-bookmark-research ~/.claude/skills/

# Create your config
cp config/bookmark-research.example.yml ~/.claude/skills/x-bookmark-research/config.yml
```

Then restart Claude Code.

## Configuration

Edit `~/.claude/skills/x-bookmark-research/config.yml`:

```yaml
# Where to save processed bookmarks
output_dir: ~/Desktop/Research/twitter-bookmarks

# Your interests (used in "Why This Matters" section)
interests:
  - "My SaaS product"
  - "AI/ML workflows"
  - "Content creation"

# Default depth: quick | standard | deep
default_depth: standard
```

The `interests` list is key — it's how Claude connects each bookmark to *your* context instead of writing generic summaries.

## Usage

```
/research-bookmarks              # Interactive - asks how many and what depth
/research-bookmarks 5            # Process 5 recent bookmarks
/research-bookmarks all          # Process all unprocessed bookmarks
/research-bookmarks <tweet-url>  # Research a specific tweet
/research-bookmarks 10 --depth deep   # 10 bookmarks with full web research
```

### Depth Levels

| Depth | What's Included | Speed |
|-------|-----------------|-------|
| `quick` | Tweet content, categorization, action items | Fast |
| `standard` | + Author bio and context via `bird about` | Moderate |
| `deep` | + Web search for broader context (needs Exa MCP) | Thorough |

## Output Format

Each bookmark becomes a markdown file like `2026-02-01-ai-workflow-tips.md`:

```markdown
---
title: "Descriptive Title Capturing the Essence"
author: "@handle (Full Name)"
date_bookmarked: 2026-02-01
original_date: 2026-01-31
category: AI & Machine Learning / LLM Applications
tweet_url: https://x.com/user/status/123456
engagement: 500 likes, 30 replies, 100 retweets
---

## Key Insight
[The actual takeaway, not a description]

## Full Content
[Verbatim tweet/thread text]

## Author Context
[Who they are and why their perspective matters]

## Why This Matters
[Connected to YOUR configured interests]

## Action Items
- [ ] Specific next step
- [ ] Another concrete action
```

See [`examples/sample-output.md`](examples/sample-output.md) for a complete example.

## Customization

### Custom Categories

Override the default category taxonomy in your config:

```yaml
categories:
  - name: "AI & Machine Learning"
    subcategories:
      - "LLM Applications"
      - "AI Tools"
  - name: "My Custom Category"
    subcategories:
      - "Subtopic A"
      - "Subtopic B"
```

### Deduplication

The command automatically skips bookmarks that have already been processed by checking `tweet_url` in existing files in your output directory.

## How It Works

1. Reads your config for output directory, interests, and preferences
2. Fetches bookmarks from Twitter/X via `bird` CLI
3. Deduplicates against already-processed bookmarks
4. For each new bookmark:
   - Parses tweet data (content, author, engagement, threads)
   - Looks up author context (standard/deep depth)
   - Searches web for broader context (deep depth only)
   - Categorizes the content
   - Generates a structured markdown file connected to your interests
5. Writes files to your configured output directory
6. Reports summary of created, skipped, and failed items

## File Structure

```
~/.claude/
  commands/
    research-bookmarks.md          # Slash command (the main logic)
  skills/
    x-bookmark-research/
      SKILL.md                     # Skill manifest
      config.yml                   # Your personal config (not committed)
      references/
        output-format.md           # Output template spec
```

## Contributing

Contributions welcome! This is a Claude Code extension — all logic lives in markdown files that Claude interprets.

To contribute:
1. Fork the repo
2. Make your changes
3. Test by installing locally (`./install.sh`) and running `/research-bookmarks`
4. Open a PR with a description of what changed and why

## License

MIT - see [LICENSE](LICENSE)
