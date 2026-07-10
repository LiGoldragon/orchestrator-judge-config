# Agent guidance — orchestrator-judge-config

Read `ARCHITECTURE.md` before editing.

Keep prompt prose public, non-secret, and organized as Markdown by judge concern.
Use NOTA for the manifest and fixtures. Do not add JSON, YAML, CSV, provider
credentials, private data, Rust binaries, or Nix-built prompt copies here.

Use orchestrator and judge terminology for new names. Keep the two packs aligned:
a change to an output grammar lands in that pack's `nota-output`, `few-shot`, and
fixtures together, so every fixture reply still parses.
