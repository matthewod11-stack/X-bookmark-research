# Output Format Specification

Generated markdown files follow this exact structure for consistent, searchable research notes.

## Filename Convention

```
YYYY-MM-DD-slug.md
```

- Date: When bookmarked (today's date for new processing)
- Slug: Kebab-case derived from title (max 50 chars)
- Examples:
  - `2026-01-30-ai-literacy-thread.md`
  - `2026-01-30-specs-as-code-workflow.md`

## Template

```markdown
---
title: [Descriptive title - not just the first line of tweet]
author: "@handle (Full Name)"
date_bookmarked: YYYY-MM-DD
original_date: YYYY-MM-DD
category: [Category / Subcategory]
tweet_url: https://x.com/user/status/ID
engagement: [#] likes, [#] replies, [#] retweets
---

## Key Insight
[1-2 sentence summary capturing WHY this is valuable. Not a description, but the insight.]

## Full Content
[Tweet text verbatim. For threads, format as:]

**1/** First tweet text

**2/** Second tweet text

[etc.]

## Author Context
[Only for --depth standard or deep]
- **[Full Name]** - [Brief description of who they are]
- [Relevant context: role, company, expertise area]
- [Why their perspective matters on this topic]

## Why This Matters
[2-3 sentences connecting this to the user's configured interests.]
Reference the specific interests/projects from config.yml to make this personal and actionable.

## Related Resources
[Optional - only if there are clear connections]
- [Link or reference to related concept]
- [Other bookmarks on similar topics]

## Action Items
- [ ] [Specific, actionable next step]
- [ ] [Another concrete action]
```

## Frontmatter Fields

| Field | Required | Format | Notes |
|-------|----------|--------|-------|
| title | Yes | String | Descriptive, not tweet's first words |
| author | Yes | `"@handle (Full Name)"` | Include both handle and display name |
| date_bookmarked | Yes | `YYYY-MM-DD` | Date of processing |
| original_date | Yes | `YYYY-MM-DD` | Tweet's creation date |
| category | Yes | `Category / Subcategory` | From standard or custom list |
| tweet_url | Yes | Full URL | `https://x.com/user/status/ID` |
| engagement | Yes | String | Format: `N likes, N replies, N retweets` |

## Default Category Taxonomy

These categories are used when no custom categories are configured:

```
AI & Machine Learning
  - LLM Applications
  - AI Philosophy
  - AI Tools

Engineering Practices
  - Documentation
  - Testing
  - Architecture
  - DevOps

Thought Leadership
  - AI Philosophy
  - Career Advice
  - Industry Trends

Product & Business
  - Strategy
  - Growth
  - Pricing

Career & Hiring
  - Job Opportunities
  - Recruiting
  - HR Tech

Tools & Automation
  - CLI Tools
  - Productivity
  - Workflows

News & Announcements
  - Product Launches
  - Company News
  - Research Papers
```

Users can override these by defining `categories` in their `config.yml`.

## Section Guidelines

### Key Insight
- One to two sentences MAX
- Focus on the **insight**, not description
- Answer: "What's the takeaway?"
- Bad: "This thread discusses AI literacy"
- Good: "AI literacy is cognitive, not technical - clear thinking matters more than prompt engineering"

### Full Content
- Preserve exact tweet text
- For threads: number each part with `**N/**` format
- Include quoted tweets with `>` blockquote
- Preserve line breaks within tweets

### Why This Matters
- Connect specifically to interests configured in `config.yml`
- Reference the user's actual projects and goals by name
- Be specific, not generic
- 2-3 sentences that make the bookmark actionable

### Action Items
- Use checkbox format: `- [ ]`
- Make actionable and specific
- Typically 2-4 items
- Tie back to user's configured interests where relevant

## Thread Handling

For multi-part threads:

1. Title should reflect the thread's main thesis
2. Number all parts in Full Content section
3. Key Insight summarizes the entire thread, not just tweet 1
4. Engagement may note "thread" in parenthetical

## Quote Tweet Handling

```markdown
## Full Content
[Main tweet text]

> **Quoted from @otheruser:**
> [Quoted tweet text]
```

## Media Handling

Note presence of media but don't embed:
```markdown
## Full Content
[Tweet text]

*[Includes: image showing X / video demonstrating Y]*
```
