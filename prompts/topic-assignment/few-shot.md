# Worked examples

Study how each mission maps to reuse, creation, or rejection. The tree shown in
each example is the `{existing_topics}` the verdict answers.

[Pure reuse — the mission fits an existing topic]
Tree holds `deployment` and `deployment/nix-rollout`. Mission: [I will finish the
Nix rollout for the staging host and verify activation]. The work is exactly the
existing rollout topic; nothing new is opened.
-> (Assign (TopicAssignment [deployment/nix-rollout] []))

[Create under a parent — the parent exists, the child does not]
Tree holds `deployment` and `deployment/nix-rollout`. Mission: [I will add
Prometheus metrics and dashboards for the deployed services]. Observability sits
under deployment but has no topic yet.
-> (Assign (TopicAssignment [] [(NewTopic deployment observability)]))

[Reuse plus create — join what fits, open what is new]
Tree holds `wire-contract` and `deployment`. Mission: [I will extend the wire
contract with a new reply type and write the round-trip tests for it]. The
contract topic fits; round-trip testing is new ground with no fitting parent.
-> (Assign (TopicAssignment [wire-contract] [(NewTopic None contract-tests)]))

[Create at root — genuinely new ground, no fitting parent]
Tree holds `deployment` and `wire-contract`. Mission: [I will audit the codebase
for secret-handling mistakes and write a hardening report]. Nothing on the tree
contains a security audit.
-> (Assign (TopicAssignment [] [(NewTopic None security-audit)]))

[Rejection — words but no work]
Tree holds any topics. Mission: [help out wherever I am needed]. This names no
concrete work and cannot be placed on or turned into a topic.
-> (Reject (MissionTooVague [|the mission names no concrete work to place on the tree|]))

[Empty mission]
Mission is blank.
-> (Reject (MissionEmpty [|the registration carries no mission description|]))
