{
  description = "orchestrator-judge-config — public prompt/config data for the orchestrator judge AI calls";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.runCommand "orchestrator-judge-config" { src = ./.; } ''
          mkdir -p "$out"
          cp -R "$src"/* "$out"/
        '';
        checks.manifest = pkgs.runCommand "orchestrator-judge-config-manifest-check" { src = ./.; } ''
          set -euo pipefail
          test -s "$src/manifest.nota"
          test -s "$src/prompts/topic-assignment/role.md"
          test -s "$src/prompts/topic-assignment/nota-output.md"
          test -s "$src/prompts/topic-assignment/few-shot.md"
          test -s "$src/prompts/triage/role.md"
          test -s "$src/prompts/triage/nota-output.md"
          test -s "$src/prompts/triage/few-shot.md"
          test -s "$src/prompts/retry-instruction.md"
          test -s "$src/prompts/diagnostics.md"
          test -s "$src/config/provider-policy.nota"
          test -s "$src/fixtures/topic-assignment/assignment-cases.nota"
          test -s "$src/fixtures/triage/routing-cases.nota"
          test -s "$src/fixtures/diagnostics/redacted-diagnostics.nota"
          if find "$src" \( -name '*.json' -o -name '*.yaml' -o -name '*.yml' -o -name '*.csv' \) | grep .; then
            echo "forbidden internal artifact format found" >&2
            exit 1
          fi
          grep -q "orchestrator-topic-assignment-judge" "$src/manifest.nota"
          grep -q "orchestrator-triage-judge" "$src/manifest.nota"
          while IFS= read -r path; do
            test -f "$src/$path" || { echo "manifest path missing: $path" >&2; exit 1; }
          done < <(grep -oE '(prompts|fixtures|config)/[^ )]+' "$src/manifest.nota" | sort -u)
          grep -q "{mission}" "$src/prompts/topic-assignment/user-template.md"
          grep -q "{existing_topics}" "$src/prompts/topic-assignment/user-template.md"
          grep -q "{incoming}" "$src/prompts/triage/user-template.md"
          grep -q "{sender}" "$src/prompts/triage/user-template.md"
          grep -q "{topic_directory}" "$src/prompts/triage/user-template.md"
          grep -q "{agent_directory}" "$src/prompts/triage/user-template.md"
          grep -q "TopicAssignment" "$src/prompts/topic-assignment/nota-output.md"
          grep -q "TopicAssignment" "$src/fixtures/topic-assignment/assignment-cases.nota"
          grep -q "TriageRouting" "$src/prompts/triage/nota-output.md"
          grep -q "TriageRouting" "$src/fixtures/triage/routing-cases.nota"
          grep -q "Reuse an existing topic" "$src/prompts/topic-assignment/reuse-before-create.md"
          grep -q "split-this-agent Report" "$src/prompts/topic-assignment/cardinality-guidance.md"
          grep -q "HardInterruption" "$src/prompts/triage/message-kinds.md"
          grep -q "never invent a recipient" "$src/prompts/triage/triage-action-space.md"
          grep -q "redacted" "$src/prompts/diagnostics.md"
          grep -q "no credential values" "$src/fixtures/diagnostics/redacted-diagnostics.nota"
          touch "$out"
        '';
      });
}
