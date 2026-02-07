# Twitter Bookmark Research

Transform Twitter/X bookmarks into structured research notes.

## Arguments

- `$ARGUMENTS` - Optional: count (number), "all", or tweet URL

## Instructions

You are processing Twitter bookmarks into structured research markdown files.

### Step 0: Load Configuration

Read the config file at `~/.claude/skills/x-bookmark-research/config.yml`.

Extract these settings:
- `output_dir` - Directory to write processed bookmark files (expand `~`)
- `interests` - List of user interests/projects for the "Why This Matters" section
- `default_depth` - Default research depth (quick|standard|deep)
- `categories` - Optional custom category taxonomy (fall back to built-in defaults)

**If the config file does not exist**, stop and tell the user:
> Configuration not found. Please create `~/.claude/skills/x-bookmark-research/config.yml` with your settings.
> You can copy the example config: `cp ~/.claude/skills/x-bookmark-research/config.example.yml ~/.claude/skills/x-bookmark-research/config.yml`

Then list the required fields and exit.

### Step 1: Parse Arguments

Analyze `$ARGUMENTS`:
- **Empty**: Ask user how many bookmarks to process and preferred depth (quick/standard/deep)
- **Number** (e.g., "10"): Process that many recent bookmarks with the configured default depth
- **"all"**: Process all bookmarks, skipping already-processed ones
- **URL** (contains "x.com" or "twitter.com"): Research single tweet
- **"--depth X"** flag: Override research depth (quick|standard|deep)

Default depth comes from `default_depth` in config (falls back to `standard` if not set).

### Step 2: Load Existing Tweet IDs (Deduplication)

Scan the configured `output_dir` for existing files:

```bash
grep -h "^tweet_url:" <output_dir>/*.md 2>/dev/null | sed 's/.*status\///' | sort -u
```

Store these IDs to skip already-processed bookmarks.

### Step 3: Fetch Bookmarks

For bookmark processing (not single URL):

```bash
bird bookmarks --json --count N
```

For single URL:
```bash
bird read "URL" --json
```

Parse the JSON output. Each bookmark contains:
- `id` - Tweet ID
- `author.handle` - @username
- `author.name` - Display name
- `text` - Tweet content
- `createdAt` - Original post date
- `stats.likes`, `stats.replies`, `stats.retweets` - Engagement
- `thread[]` - Thread parts if applicable
- `quotedTweet` - Quoted tweet if present

### Step 4: Process Each Bookmark

For each new (non-duplicate) bookmark:

#### 4a. Parse Tweet Data
Extract all relevant fields from JSON.

#### 4b. Author Research (standard/deep depth)

```bash
bird about @handle --json
```

Get author context: bio, follower count, location, account age.

#### 4c. Web Search (deep depth only)

Use Exa MCP `web_search_exa` tool to find:
- Author's other notable work
- Context on topics mentioned
- Related discussions

#### 4d. Analyze & Categorize

If custom `categories` are defined in config, use those. Otherwise use the default taxonomy:

- AI & Machine Learning / [subcategory]
- Engineering Practices / [subcategory]
- Thought Leadership / [subcategory]
- Product & Business / [subcategory]
- Career & Hiring / [subcategory]
- Tools & Automation / [subcategory]
- News & Announcements / [subcategory]

#### 4e. Generate Markdown

Create file following template from `~/.claude/skills/x-bookmark-research/references/output-format.md`:

**Filename**: `YYYY-MM-DD-slug.md` where:
- Date is today
- Slug is kebab-case title (max 50 chars)

**Content**:
```markdown
---
title: [Descriptive title - capture the essence, not first words]
author: "@handle (Full Name)"
date_bookmarked: [today]
original_date: [tweet date]
category: [Category / Subcategory]
tweet_url: https://x.com/[user]/status/[id]
engagement: [N] likes, [N] replies, [N] retweets
---

## Key Insight
[1-2 sentence summary of WHY this matters - the insight, not description]

## Full Content
[Tweet text. For threads, use **N/** numbering]

## Author Context
[For standard/deep: who is this person, why their perspective matters]

## Why This Matters
[Connect to user's configured interests from config.yml]

## Action Items
- [ ] [Specific actionable step]
- [ ] [Another concrete action]
```

#### 4f. Write File

Write to the configured `output_dir`.

### Step 5: Report Summary

After processing, report:
- **Created**: N new research files
- **Skipped**: N already processed
- **Failed**: N errors (with reasons)

List the files created with their titles.

## Quality Guidelines

### Key Insight Section
- NOT a description ("This thread discusses...")
- IS the insight ("AI literacy is cognitive, not technical...")
- Ask: "What's the takeaway someone would remember?"

### Why This Matters Section
Connect specifically to the user's configured interests from `config.yml`. Reference the actual interest names/projects listed there. Be specific, not generic.

### Action Items
- Checkbox format: `- [ ]`
- Specific and actionable
- 2-4 items typical
- Tie actions back to user's configured interests where relevant

### Thread Handling
- Title reflects entire thread thesis
- Number all parts: `**1/**`, `**2/**`, etc.
- Key Insight covers full thread, not just first tweet

## Depth Levels

| Depth | What's Included |
|-------|-----------------|
| quick | Tweet content, basic analysis, action items |
| standard | + Author context via `bird about` |
| deep | + Web search for broader context |

## Error Handling

- If `bird` command fails: Report error, suggest checking authentication
- If file write fails: Report path and error
- If author lookup fails: Continue without Author Context section
- If web search fails (deep mode): Continue with standard depth content
- If config file missing: Prompt user to create it (see Step 0)
