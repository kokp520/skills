.PHONY: default new list help init validate add

# Default action
default: help

# Create a new skill template
# Usage: make new name=my-skill
new:
	@if [ -z "$(name)" ]; then \
		echo "[ERROR] Please specify the 'name' parameter."; \
		echo "Usage example: make new name=deploy-helper"; \
		exit 1; \
	fi
	@chmod +x src/cli.js
	@node src/cli.js create $(name)

# List local skills
list:
	@chmod +x src/cli.js
	@node src/cli.js list

# Validate all local skills formatting (Frontmatter static checks)
validate:
	@chmod +x src/cli.js
	@node src/cli.js validate

# Snapshot copy specified skill into current project's config directory
# Usage: make add name=my-skill
add:
	@if [ -z "$(name)" ]; then \
		echo "[ERROR] Please specify the 'name' parameter."; \
		echo "Usage example: make add name=my-skill"; \
		exit 1; \
	fi
	@chmod +x src/cli.js
	@node src/cli.js add $(name)

# Initialize the project environment
init:
	@chmod +x src/cli.js
	@echo "[SUCCESS] Initialization complete. You can now run 'make new name=xxxx' to start developing your custom skills!"

# Display help documentation
help:
	@chmod +x src/cli.js
	@node src/cli.js help
