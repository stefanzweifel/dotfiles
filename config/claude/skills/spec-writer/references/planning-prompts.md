# Planning Prompts

## Generate Implementation Plan

### TDD Approach (Recommended)

```
Draft a detailed, step-by-step blueprint for building this project. 

Then, once you have a solid plan, break it down into small, iterative 
chunks that build on each other. Look at these chunks and then go 
another round to break it into small steps. 

Review the results and make sure that the steps are small enough to be 
implemented safely with strong testing, but big enough to move the 
project forward. Iterate until you feel that the steps are right sized 
for this project.

From here you should have the foundation to provide a series of prompts 
for a code-generation LLM that will implement each step in a test-driven 
manner. 

Prioritize best practices, incremental progress, and early testing, 
ensuring no big jumps in complexity at any stage. 

Make sure that each prompt builds on the previous prompts, and ends with 
wiring things together. There should be no hanging or orphaned code that 
isn't integrated into a previous step.

Make sure and separate each prompt section. Use markdown. Each prompt 
should be tagged as text using code tags. The goal is to output prompts, 
but context, etc is important as well.

<SPEC>
[paste spec here]
</SPEC>
```

### Non-TDD Approach

```
Draft a detailed, step-by-step blueprint for building this project. 

Then, once you have a solid plan, break it down into small, iterative 
chunks that build on each other. Look at these chunks and then go 
another round to break it into small steps. 

Review the results and make sure that the steps are small enough to be 
implemented safely, but big enough to move the project forward. Iterate 
until you feel that the steps are right sized for this project.

From here you should have the foundation to provide a series of prompts 
for a code-generation LLM that will implement each step. 

Prioritize best practices, and incremental progress, ensuring no big 
jumps in complexity at any stage. 

Make sure that each prompt builds on the previous prompts, and ends with 
wiring things together. There should be no hanging or orphaned code that 
isn't integrated into a previous step.

Make sure and separate each prompt section. Use markdown. Each prompt 
should be tagged as text using code tags. The goal is to output prompts, 
but context, etc is important as well.

<SPEC>
[paste spec here]
</SPEC>
```

## Generate TODO Checklist

```
Based on the implementation plan, create a todo.md that I can use as a 
checklist. 

Be thorough. Include all steps from the plan as checkable items. 
Group by phase. Include verification steps.

Format:
- [ ] Task description
  - [ ] Sub-task if needed
```

## Generate Architecture Doc

```
Based on the specification, create an ARCHITECTURE.md that includes:

1. **System Overview**: High-level Mermaid diagram showing main components

2. **Component Breakdown**: Each major component with:
   - Purpose
   - Responsibilities  
   - Key files/classes
   - Dependencies

3. **Data Flow**: How data moves through the system (Mermaid sequence diagram)

4. **Key Technical Decisions**: 
   - Why we chose X over Y
   - Trade-offs considered

5. **File Structure**: Proposed directory layout with explanations

6. **Integration Points**: How components communicate

Make it visual with Mermaid diagrams where helpful.
```

## Prompt Quality Checklist

Each generated prompt should include:

- [ ] **Context**: What exists, what files to reference
- [ ] **Specific task**: Clear, actionable instruction
- [ ] **Patterns to follow**: Point to existing code as examples
- [ ] **Verification**: How to know it's done (tests, expected output)
- [ ] **Integration**: How this connects to previous work
- [ ] **Scope limit**: What NOT to do (prevent scope creep)

## Example Well-Formed Prompt

```markdown
### Step 2.3: Add Repository Sync Job

**Context**: 
- Job base class exists at `app/Jobs/BaseJob.php`
- GitHub API client at `app/Services/GitHubClient.php`
- Repository model at `app/Models/Repository.php`

**Prompt**:
Create a SyncRepositoryJob that fetches repository metadata from GitHub 
and updates the local database.

Follow the pattern in `app/Jobs/ExampleJob.php` for job structure.

The job should:
1. Accept a Repository model
2. Fetch latest data from GitHub API using GitHubClient
3. Update: name, description, stars, forks, open_issues_count, updated_at
4. Handle rate limiting by re-queuing with delay
5. Log sync results

Do NOT modify the Repository model or create migrations.

**Verification**:
- [ ] `php artisan test --filter=SyncRepositoryJobTest` passes
- [ ] Job can be dispatched: `SyncRepositoryJob::dispatch($repo)`
- [ ] Rate limit triggers re-queue, not failure
```
