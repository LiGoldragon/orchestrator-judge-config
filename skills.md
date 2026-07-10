# skills — orchestrator-judge-config

- Markdown is the prompt prose format.
- NOTA is the manifest and fixture format.
- Prompt edits should not require rebuilding the orchestrator or its judge
  adapter.
- Keep the packs orchestrator-specific; do not generalize into a judge-anything
  prompt repository.
- Never commit secrets, provider tokens, private data, or live eval output.
- Fixtures are test material. A fixture reply is a canned verdict for parse
  validation, not a live decision.
- When an output grammar changes, update `nota-output`, `few-shot`, and the
  fixtures for that pack together.
