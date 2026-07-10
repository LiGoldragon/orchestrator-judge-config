# Diagnostic discipline

Diagnostics are debug-only and non-load-bearing. They must not reveal provider
credentials, raw private message content beyond the request scope, or a full
sender testimony. Prefer `None` when the verdict is clear.

When diagnostic correlation is needed, use a redacted summary or a stable hash
chosen by the adapter. The prompt pack must not require storing raw model
reasoning or live routing output in this repository.
