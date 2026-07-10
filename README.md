# orchestrator-judge-config

Public prompt and configuration data for the orchestrator component's two judge
AI calls: topic assignment and message triage.

Prompt prose lives here so prompt edits do not require Rust or Nix rebuilds of the
orchestrator adapter. The layout keeps prompts as Markdown by judge concern,
indexes them with a NOTA manifest, and keeps test data in fixture files whose
reply texts parse under the pack output grammars.
