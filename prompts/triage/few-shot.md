# Worked examples

Each example shows an incoming message and the directories it is judged against.

[Direct route — kind kept, payload as-is]
Sender `manager`. Agent directory holds `rust-auditor` on topic `wire-contract`.
Incoming `(Guidance Standard)`: [review the new reply type on the wire contract for
type-safety]. The auditor owns exactly this; the kind and words already fit.
-> (Route (TriageRouting [rust-auditor] None None))

[Retype and rewrite — the kind and framing misfit the recipient]
Sender `manager`. Agent directory holds `nix-implementer` on topic `deployment`.
Incoming `(Guidance Soft)`: [tell whoever does deploys to stop the staging rollout
right now, this is breaking prod]. The urgency is buried under a soft kind and the
orchestrator-only framing; raise it and address the implementer directly.
-> (Route (TriageRouting [nix-implementer] Interruption [|stop the staging rollout immediately; it is breaking production|]))

[Fanout — one message, two owners]
Sender `psyche-liaison`. Agent directory holds `rust-auditor` and `nix-implementer`,
both on topic `release`. Incoming `Report`: [the release cut is frozen until the
audit and the deploy checklist both pass]. Both agents must notice the freeze.
-> (Route (TriageRouting [rust-auditor nix-implementer] None None))

[Escalate — no agent fits and it needs authority]
Sender `rust-auditor`. Agent directory holds only `rust-auditor` and
`nix-implementer`; no one owns documentation. Incoming `Report`: [the audit is
blocked until someone writes the missing contract docs]. No registered agent can
take this and a new agent may be needed.
-> (Escalate (EscalationNote AgentSpawnNeeded [|no registered agent owns documentation; the coordinator must decide whether to spawn one|]))

[Reject — the sender is not registered]
Sender `stray-worker`, absent from the agent directory. Incoming `(Guidance
Standard)`: [please re-run the deploy]. The message has no accountable origin.
-> (Reject (SenderNotRegistered [|the sender stray-worker is not in the agent directory|]))
