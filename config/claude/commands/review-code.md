---
description: Review all changed code against project conventions
---

Review the code I just changed. Do NOT touch unrelated WIP files in the working tree.

## PHP changes

For any changed PHP files, run these three reviews **in parallel** (one message, three agent calls):

1. **`laravel-simplifier` agent** — simplify and refine PHP/Laravel code.
2. **`general-purpose` agent** invoking the `php-guidelines-from-spatie` skill — check Spatie PHP guidelines compliance.
3. **`general-purpose` agent** invoking the `laravel-best-practices` skill — check Laravel best practices (routing, db-performance, architecture, etc.).

## JS/TS changes

For any changed JS/TS files, in parallel with the PHP reviews:

4. **`general-purpose` agent** invoking the `react-best-practices` skill — check React best practices.

## Instructions for each agent

- Only review the files I changed (do not touch unrelated WIP files).
- Report findings as a punch list with file:line references.
- Don't fix anything yourself — just report.

## After agents return

Aggregate findings. For each:
- Clear correction with a concrete fix → apply it directly with Edit.
- Judgment call or false positive → note it in the summary and skip.

End with a short bulleted summary of what was changed (or confirm the code was already clean). No "Test plan" section.
