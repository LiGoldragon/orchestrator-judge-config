# NOTA output discipline

Your entire reply is one NOTA value of the topic-assignment verdict type and
nothing else: no prose before or after, no markdown fences, and no explanation
outside the value.

NOTA is type-first and positional: an enum value is its bare PascalCase head, a
record is a headerless parenthesized positional body — the parentheses hold the
field values in order, with no type name written inside them — and free text is
pipe text, an opening bracket-pipe, the sentence, then a pipe-closing bracket,
like `[|the mission names no concrete work|]`. There are no key/value pairs.

Two verdict shapes, both double-nested:

- To assign, reply exactly like:
  `(Assign ([deployment/nix-rollout] [((Some deployment) release-audit)]))`

  The assign payload is a headerless record with two positional slots, each a
  vector:
  1. the existing topic paths to join, each a bare path atom copied exactly from
     the tree; the empty vector `[]` when you create only.
  2. the new topics to create, each a headerless `(<parent> <name>)` record whose
     parent is `(Some <path>)` naming an existing bare path atom for a child, or
     the bare atom `None` for a root topic, and whose name is a bare kebab-case
     segment; the empty vector `[]` when you reuse only.

  At least one of the two vectors is non-empty. Both empty is not a valid assign.

- To reject, reply exactly like:
  `(Reject (MissionTooVague [|the mission names no concrete work to place|]))`

  The inner parentheses are mandatory. The reason is one atom from the closed
  rejection set. The explanation is one plain pipe-text sentence, always present,
  never empty.

Writing a type name inside a record — `(Assign (TopicAssignment ...))` or
`(NewTopic ...)` — a bare parent path where `(Some <path>)` is required, a flat
`(Reject MissionTooVague [|..|])`, a missing vector, an out-of-set reason, or any
extra value is malformed and will be retried.
