# orchestrator-judge-config — architecture

`orchestrator-judge-config` owns the public prompt and configuration data for the
orchestrator component's two judge AI calls: topic assignment and message triage.

Prompts are Markdown files grouped by judge concern and indexed by a NOTA
manifest. Prompt data stays outside Rust and Nix-built binaries so prompt edits
load into the orchestrator adapter daemon without a Rust or Nix rebuild.

## The two calls

The orchestrate component gains an orchestrator decision seat. Agents register
with a mandatory brief mission description.

Topic assignment runs when an agent registers in Automatic mode. Given the
mission and the current topic tree, the judge chooses existing topics to join and
new topics to create, reusing before creating.

Triage runs when a message is addressed to the orchestrator seat. Given the
incoming message, its sender, and the recipient directories, the judge routes to
one or more registered agents, keeps or retypes the kind, forwards or rewrites the
payload, or escalates to the coordinator — the agent holding the seeded catch-all
topic.

## Boundary

Owned here:

- public prompt prose for the topic-assignment and triage judges;
- the NOTA manifest that names prompt files, prompt order, config, and fixtures;
- non-secret provider and model-selection configuration for the adapter;
- test fixtures whose reply texts parse under the pack output grammars.

Not owned here:

- provider credentials, tokens, or secret values;
- the orchestrator adapter daemon or any executable code;
- the orchestrate seat, topic-tree, or message-routing implementation;
- generic judge-anything prompt packs.

## Output grammar authority

Each pack's `nota-output` section defines one strict output grammar. The adapter
renders system plus user messages and parses the model reply as exactly one NOTA
value of that grammar; any deviation is a format failure handled caller-side.
Model verdicts never carry transport-failure reasons — unavailability and timeout
live with the caller, not the model.

The sibling contract crate `signal-orchestrator-judge` holds the Rust types for
these grammars. The `nota-output` sections and fixtures are reconciled against
its derive codec (see below).

## Grammar reconciliation (against signal-orchestrator-judge)

This pack was authored before the contract crate existed and invented a few
shapes that the crate's NOTA derive codec does not use. The `orchestrator-judge`
adapter tests wire these FixtureSets in and decode every canned reply through the
real model-verdict types, so the fixtures and `nota-output` grammar were corrected
to the crate's actual codec:

- Records are headerless positional bodies. An assign payload is
  `([<reuse>] [<create>])`, not `(TopicAssignment ...)`; a new topic is
  `(<parent> <name>)`, not `(NewTopic ...)`; a route is `([<recipients>]
  <retyped> <rewritten>)`, not `(TriageRouting ...)`; an escalation is
  `(<reason> <detail>)`, not `(EscalationNote ...)`. NOTA writes the type by
  position, never as a token inside the parentheses.
- Optional slots are `(Some <value>)` or the bare atom `None`. A new topic's
  parent is `(Some <path>)` or `None` (was a bare path atom); a retyped kind is
  `(Some Interruption)` etc. (was a bare kind); a rewritten message is a full
  `(Some (<kind> <subject> <content>))` orchestrator message (was bare pipe text).
- The escalation coordinator-reason is free text in the crate
  (`EscalationReason`, a non-empty string newtype), not a closed enum. The four
  invented atoms `NoTopicFits`, `AmbiguousOwnership`, `NeedsAuthority`,
  `AgentSpawnNeeded` are kept as *recommended* vocabulary; the grammar no longer
  claims they are a closed set. The crate's clean rejection enums
  (`TopicAssignmentRejectionReason`, `TriageRejectionReason`) matched the invented
  atoms exactly and were left unchanged.
- Single-token pipe text is a redundant NOTA delimiter and was rejected by the
  codec; such a diagnostics fixture value was made genuine multi-word text.

The contract crate's types were correct as shipped and needed no change.

## Fixture rule

Fixture files are test material. A fixture reply is a canned model verdict used to
validate loading and parsing; it is not a live routing or assignment decision.
