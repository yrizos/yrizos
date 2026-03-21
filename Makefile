.PHONY: install-hooks uninstall-hooks

# Point this repository at versioned hooks under .githooks/.
install-hooks:
	chmod +x .githooks/commit-msg .githooks/pre-commit
	git config core.hooksPath .githooks

uninstall-hooks:
	git config --unset core.hooksPath || true
