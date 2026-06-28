---
name: spec-writer
description: Create detailed software specifications through iterative Q&A brainstorming. Use when starting a new project, feature, or app. Produces spec.md, architecture docs, implementation plans with step-by-step prompts, and todo checklists. Triggers include "write a spec", "plan this project", "brainstorm this idea", "create implementation plan", or any new project/feature planning.
---

# Spec Writer

Transform ideas into developer-ready specifications through structured brainstorming and planning.

## The Process

### Phase 1: Idea Honing (Brainstorm)

Ask ONE question at a time to develop a thorough spec. Each question builds on previous answers. Goal: detailed specification ready for implementation.

Start with:
```
I'll help you develop a detailed spec for this idea. I'll ask one question at a time.

Let's start: [First clarifying question about the core problem/goal]
```

Key areas to explore:
- **Core problem**: What pain point does this solve?
- **Users**: Who uses this? What are their workflows?
- **Features**: What are the must-haves vs nice-to-haves?
- **Data**: What entities exist? How do they relate?
- **Integrations**: What external systems are involved?
- **Constraints**: Performance, security, tech stack requirements?
- **Edge cases**: What could go wrong? How to handle it?

When brainstorming concludes naturally, compile into SPEC.md.

### Phase 2: Architecture

Create ARCHITECTURE.md covering:
- System overview diagram (Mermaid)
- Component breakdown
- Data flow
- Key technical decisions
- File/folder structure

### Phase 3: Implementation Plan

Break the spec into small, iterative chunks:

1. **First pass**: Major phases/milestones
2. **Second pass**: Break each phase into tasks
3. **Third pass**: Ensure tasks are:
   - Small enough for safe implementation with tests
   - Big enough to move the project forward
   - Building on previous tasks (no orphaned code)
   - Ending with integration/wiring

Output: PROMPT_PLAN.md with ready-to-use prompts for each step.

### Phase 4: Checklist

Generate TODO.md as a checkable list that tracks progress.

## Output Structure

```
analysis/                    # or docs/, specs/, etc.
├── SPEC.md                  # Full specification
├── ARCHITECTURE.md          # System design
├── PROMPT_PLAN.md           # Step-by-step implementation prompts
├── TODO.md                  # Checklist version
└── phases/                  # Optional: detailed phase docs
    ├── 01-phase-name.md
    ├── 02-phase-name.md
    └── ...
```

## SPEC.md Template

```markdown
# [Project Name] Specification

## Overview
[One paragraph summary]

## Problem Statement
[What pain point this solves]

## Users & Personas
[Who uses this and how]

## Features

### Must Have (MVP)
- [ ] Feature 1: [description]
- [ ] Feature 2: [description]

### Should Have
- [ ] Feature 3: [description]

### Nice to Have
- [ ] Feature 4: [description]

## Data Model
[Entities, relationships, key fields]

## User Flows
[Step-by-step workflows for key actions]

## Technical Requirements
- Stack: [technologies]
- Integrations: [external services]
- Performance: [requirements]
- Security: [considerations]

## Edge Cases & Error Handling
[What could go wrong and how to handle it]

## Success Criteria
[How do we know it's done? What tests prove it works?]

## Open Questions
[Anything still TBD]
```

## PROMPT_PLAN.md Format

Each prompt section should:
1. Reference what exists (files, patterns to follow)
2. State the specific task
3. Include verification criteria (tests, expected output)
4. Be tagged with markdown code blocks for easy copy/paste

```markdown
## Phase 1: [Name]

### Step 1.1: [Task Name]

**Context**: [What exists, what patterns to follow]

**Prompt**:
\`\`\`
[Ready-to-use prompt for the AI agent]

Verification:
- [ ] Test X passes
- [ ] Feature Y works as expected
\`\`\`

### Step 1.2: [Next Task]
...
```

## Best Practices

1. **One question at a time** during brainstorming — don't overwhelm
2. **Be specific** — vague specs produce vague implementations
3. **Include verification** — every feature needs a "done" signal
4. **Reference patterns** — point to existing code as examples
5. **Small steps** — each prompt should be achievable in one session
6. **No orphans** — every step ends with integration
7. **Test-first thinking** — define expected behavior before implementation

## When to Use Each Phase

| Situation | Start At |
|-----------|----------|
| Vague idea, exploring | Phase 1 (Brainstorm) |
| Clear requirements, need structure | Phase 2 (Architecture) |
| Architecture known, need execution plan | Phase 3 (Plan) |
| Resuming existing project | Phase 4 (TODO review) |
