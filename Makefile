.DEFAULT_GOAL := help
.PHONY: help hooks-install hooks-uninstall lint fix

help: ## Show this help
	@if [ -t 1 ] && [ -z "$$NO_COLOR" ]; then color=1; else color=; fi; awk -v color="$$color" ' \
		BEGIN { \
			b = color ? "\033[1m" : ""; c = color ? "\033[36m" : ""; d = color ? "\033[2m" : ""; r = color ? "\033[0m" : ""; \
			printf "%sUsage:%s make %s<target>%s\n\n%sTargets:%s\n", b, r, c, r, b, r \
		} \
		/^[a-zA-Z0-9_-]+:.*## / { \
			split($$0, p, /:.*## /); \
			printf "  %s%-18s%s %s%s%s\n", c, p[1], r, d, substr($$0, index($$0, "## ") + 3), r \
		}' $(MAKEFILE_LIST)

hooks-install: ## Install the pre-commit and commit-msg hooks
	pre-commit install --hook-type pre-commit --hook-type commit-msg

hooks-uninstall: ## Remove the pre-commit and commit-msg hooks
	pre-commit uninstall --hook-type pre-commit --hook-type commit-msg

lint: ## Run all linters on every file
	pre-commit run --all-files

fix: ## Apply every automatic fix, then report what remains
	-pre-commit run --all-files
	pre-commit run --all-files
