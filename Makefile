# Declare all relevant targets as phony to prevent conflicts with files
.PHONY: duck duck-help duck-status duck-log log status

# Primary 'duck' target that delegates to subcommands
duck:
	@# Check if a subcommand is provided
	@if [ "$(word 2,$(MAKECMDGOALS))" = "" ]; then \
		$(MAKE) duck-help; \
	else \
		subcommand=$(word 2,$(MAKECMDGOALS)); \
		if [ "$$subcommand" = "status" ]; then \
			$(MAKE) duck-status; \
		elif [ "$$subcommand" = "log" ]; then \
			$(MAKE) duck-log; \
		else \
			echo "Unknown duck command: $$subcommand"; \
			$(MAKE) duck-help; \
		fi \
	fi
	@# Prevent make from trying to build the subcommand as a separate target
	@exit 0

# Help target that lists all available duck subcommands
duck-help:
	@echo "DuckDNS Makefile - Available commands:"
	@echo "  make duck status   - Runs the cron search command"
	@echo "  make duck log      - Displays the contents of duck.log"

# Subcommand 'status' that checks for the cron process
duck-status:
	@echo "Running: ps -ef | grep cr[o]n"
	ps -ef | grep cr[o]n

# Subcommand 'log' that displays the contents of duck.log
duck-log:
	@echo "Running: cat duck.log"
	cat duck.log

# Dummy targets to prevent make from throwing errors for 'log' and 'status'
log:
	@:

status:
	@:
