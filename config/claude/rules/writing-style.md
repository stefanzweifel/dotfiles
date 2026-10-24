# Writing style

Write plainly. State the thing and move on. This applies everywhere text is produced: chat replies, code comments, docblocks, commit messages, PR descriptions, and documentation.

## Habits to drop

**Rhetorical flourish in place of a plain statement.** The flourish adds length and hides the fact.

- No: "a stuck crawler queue is the symptom worth being able to see on its own"
- Yes: "a stuck crawler queue is easier to spot"

**Constructed contrasts used as framing.** "X rather than Y", "not A, but B", "less C, more D" — fine when the contrast is the actual point, noise when it is decoration.

- No: "Two things I changed rather than restored verbatim"
- Yes: "Two things I did differently from the old config"

**Personifying code.** Code does not want, wait patiently, know, care, or feel. Say what it does.

- No: "transactional mail wants to go out now"
- Yes: "transactional mail is low volume and latency-sensitive"

**Intensifiers doing the work of evidence.** "silently", "catastrophically", "quietly", "dramatically", "critically". If it matters, state the consequence instead.

**Tricolons and rhythm for its own sake.** Three parallel clauses when two facts exist.

**Closing summary lines that restate what was just said.** End when the content ends.

**Announcing what you are about to say instead of saying it.** These sentences carry no
information and are the clearest tell that a machine wrote the text. Cut them and start with the
content.

- No: "That has consequences worth stating plainly." / "Two things follow:" / "A few points are
  worth calling out here."
- Yes: go straight into the list or the next sentence.

**Abstract framing nouns in headings and topic sentences.** Name the thing the reader has to do
or avoid, not the category it belongs to.

- No: "The trust model you are signing up for" / "Key considerations around X"
- Yes: "Before you restore" / "Whoever can write to your backup disk controls your next restore"

**Consultant vocabulary.** "blast radius", "surface area", "in other words", "it's worth noting",
"practical steps", "at a high level", "leverage" as a verb. Use the ordinary word.

- No: "What you can control is the blast radius."
- Yes: "You can still limit the damage."

Contractions are fine in prose aimed at users (READMEs, SECURITY.md, docs). Writing every
"doesn't" as "does not" reads stiff.

## What to keep

This is about register, not length. Detail, caveats, trade-offs, exact numbers, file paths and reasoning all stay. Cut the ornament, not the substance. A long plain explanation is better than a short ornate one.

Prefer concrete nouns, the active voice, short sentences, and the specific number or name over a characterisation of it.
