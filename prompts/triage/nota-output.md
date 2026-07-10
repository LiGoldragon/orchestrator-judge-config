# NOTA output discipline

Your entire reply is one NOTA value of the triage verdict type and nothing else:
no prose before or after, no markdown fences, and no explanation outside the value.

NOTA is type-first and positional: an enum value is its bare PascalCase head, a
record is a headerless parenthesized positional body — the parentheses hold the
field values in order, with no type name written inside them — and free text is
pipe text, an opening bracket-pipe, the text, then a pipe-closing bracket, like
`[|route this to the auditor|]`. An optional slot is `(Some <value>)` when present
or the bare atom `None` when absent. There are no key/value pairs.

Three verdict shapes, each double-nested:

- To route, reply like:
  `(Route ([rust-auditor nix-implementer] (Some (Guidance Hard)) (Some ((Guidance Hard) [|raise the freeze|] [|rewritten payload|]))))`

  The route payload is a headerless record with three positional slots:
  1. the recipient agent ids, a vector of bare atoms copied from the agent
     directory; never empty on a route.
  2. the retyped kind as `(Some <kind>)`, or the bare atom `None` to keep the
     incoming kind. A kind is `(Guidance Soft|Standard|Hard)`, `Interruption`, or
     `Report`, so a retype reads `(Some Interruption)` or `(Some (Guidance Hard))`.
  3. the rewritten message as `(Some (<kind> <subject> <content>))` — a full
     orchestrator message whose subject and content are pipe text — or the bare
     atom `None` to forward the sender's payload unchanged.

- To escalate, reply like:
  `(Escalate (NoTopicFits [|no registered agent owns this work|]))`

  The escalate payload is a headerless `(<coordinator-reason> <detail>)` record.
  The coordinator reason is a short free-text label — a bare word or pipe-text
  phrase — naming why the coordinator must decide; `NoTopicFits`,
  `AmbiguousOwnership`, `NeedsAuthority`, and `AgentSpawnNeeded` are the
  recommended labels. The detail is one plain pipe-text sentence.

- To reject, reply like:
  `(Reject (SenderNotRegistered [|the sender is not in the agent directory|]))`

  The reason is one atom from the closed rejection set; the explanation is one
  plain pipe-text sentence, always present, never empty.

The inner parentheses are mandatory. Writing a type name inside a record —
`(Route (TriageRouting ...))` or `(Escalate (EscalationNote ...))` — a bare kind or
bare rewritten text where `(Some <value>)` is required, an empty recipient list on
a route, an out-of-set rejection atom, or any extra value is malformed and will be
retried.
