# Variables
HOST = $(shell hostname)
FLAKE = .#$(HOST)

# Default target
.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: switch
switch: ## Apply changes and switch to the new generation
	sudo nixos-rebuild switch --flake $(FLAKE) --show-trace

.PHONY: test
test: ## Apply changes temporarily (dry-run/test)
	sudo nixos-rebuild test --flake $(FLAKE) --show-trace

.PHONY: boot
boot: ## Set the new generation as the default for the next boot
	sudo nixos-rebuild boot --flake $(FLAKE)

.PHONY: update
update: ## Update all inputs in flake.lock
	nix flake update

.PHONY: check
check: ## Check for syntax errors or flake issues
	nix flake check

.PHONY: gc
gc: ## Collect garbage (clean up old generations)
	sudo nix-collect-garbage -d
	nix-collect-garbage -d

.PHONY: diff
diff: ## Show what changed between generations (requires nix-diff)
	nix store diff-closures /nix/var/nix/profiles/system-*-link /nix/var/nix/profiles/system

.PHONY: history
history: ## List system generations
	nix-env --list-generations --profile /nix/var/nix/profiles/system
