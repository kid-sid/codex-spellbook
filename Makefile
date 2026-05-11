PYTHON ?= $(shell \
	command -v python3 >/dev/null 2>&1 && echo python3 || \
	command -v python  >/dev/null 2>&1 && echo python  || \
	command -v py      >/dev/null 2>&1 && echo py      || \
	( test -n "$$USERPROFILE" && test -x "$$USERPROFILE/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe" && echo "$$USERPROFILE/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe" ) || \
	echo python3 \
)

.PHONY: help lint validate count

help: ## List available targets
	@awk 'BEGIN {FS = ": ## "}; /^[a-zA-Z0-9_-]+: ## / {printf "%-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: ## Run markdown lint checks
	$(PYTHON) scripts/lint_markdown.py

validate: ## Run repository validation checks
	$(PYTHON) scripts/validate_skills.py
	$(PYTHON) scripts/validate_task_prompts.py
	$(PYTHON) scripts/validate_agent_templates.py

count: ## Print content counts
	$(PYTHON) scripts/count_content.py
