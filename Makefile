PYTHON ?= python3

.PHONY: help lint validate count

help: ## List available targets
	@awk 'BEGIN {FS = ": ## "}; /^[a-zA-Z0-9_-]+: ## / {printf "%-12s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

lint: ## Run markdown lint checks
	$(PYTHON) scripts/lint_markdown.py

validate: ## Run repository validation checks
	$(PYTHON) scripts/validate_instructions.py
	$(PYTHON) scripts/validate_task_prompts.py
	$(PYTHON) scripts/validate_agent_templates.py

count: ## Print content counts
	$(PYTHON) scripts/count_content.py
