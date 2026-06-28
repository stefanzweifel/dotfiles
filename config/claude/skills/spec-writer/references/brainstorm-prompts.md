# Brainstorm Question Bank

## Starting Questions

### Problem Space
- What problem are you trying to solve?
- Who experiences this problem most acutely?
- How are people solving this today? What's broken about that?
- What triggered the need for this now?

### Users
- Who are the primary users? Secondary?
- What's their technical skill level?
- What devices/contexts will they use this in?
- What's their workflow before/after using this?

### Core Functionality
- If this could only do ONE thing, what would it be?
- What's the simplest version that would be useful?
- What would make someone choose this over alternatives?

## Deepening Questions

### Features
- Walk me through the ideal user journey from start to finish
- What happens when [edge case]?
- How should errors be communicated to users?
- What data needs to persist vs. what's ephemeral?

### Data & Relationships
- What are the main "things" (entities) in the system?
- How do they relate to each other?
- What's the source of truth for [entity]?
- What happens to related data when something is deleted?

### Integrations
- What external services does this need to talk to?
- What's the authentication/authorization model?
- What APIs are available? Rate limits? Costs?
- What happens when an external service is down?

### Scale & Performance
- How many users/records are we expecting?
- What operations need to be fast? How fast?
- What can be async/background?
- What's the acceptable latency for [operation]?

## Closing Questions

### MVP Scoping
- What's absolutely required for v1?
- What can wait for v2?
- What would you cut if you had half the time?

### Success Criteria
- How will you know this is working?
- What metrics matter?
- What does "done" look like for each feature?

### Risks & Unknowns
- What are you most uncertain about?
- What could derail this project?
- What assumptions are we making that might be wrong?

## Compilation Prompt

When brainstorming is complete:

```
Now that we've explored the requirements, compile our findings into a 
comprehensive, developer-ready specification.

Include:
- All requirements and features (prioritized)
- Architecture choices we discussed
- Data model with relationships
- Error handling strategies
- Testing plan with specific test cases
- Open questions or TBDs

Format it so a developer can immediately begin implementation.
```
