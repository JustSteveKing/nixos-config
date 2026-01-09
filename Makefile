# ==============================================================================
# Makefile for Managing NixOS Flake Configuration
# ==============================================================================

# Use bash for all recipes
SHELL := /bin/bash

# Variables
HOST = $(shell hostname)
FLAKE = .#$(HOST)

.DEFAULT_GOAL := help

# ------------------------------------------------------------------------------
# System Management
# ------------------------------------------------------------------------------

.PHONY: switch
switch: ## 🚀 Apply and switch to the new system generation
	sudo nixos-rebuild switch --flake $(FLAKE) --show-trace

.PHONY: test
test: ## 🧪 Build and test the new generation without switching
	sudo nixos-rebuild test --flake $(FLAKE) --show-trace

.PHONY: boot
boot: ## 👢 Build and set the new generation as the default for the next boot
	sudo nixos-rebuild boot --flake $(FLAKE)

# ------------------------------------------------------------------------------
# Code Quality & Formatting
# ------------------------------------------------------------------------------

.PHONY: fmt
fmt: ## 💅 Formats all .nix files in the repository
	nix run nixpkgs#nixpkgs-fmt -- .

.PHONY: lint
lint: ## 🧐 Check for errors, style issues, and unused code
	@echo "--- Checking flake syntax..."
	nix flake check --all-systems
	@echo "--- Linting with statix..."
	nix run nixpkgs#statix -- check .
	@echo "--- Checking for dead code with deadnix..."
	nix run nixpkgs#deadnix -- .

# ------------------------------------------------------------------------------
# Maintenance & History
# ------------------------------------------------------------------------------

.PHONY: update
update: ## ⬆️  Update all flake inputs
	nix flake update

.PHONY: gc
gc: ## 🗑️ Remove old generations and optimize the Nix store
	sudo nix-collect-garbage -d
	nix-collect-garbage -d
	nix-store --optimise

.PHONY: history
history: ## 📜 List all system generations
	nix-env --list-generations --profile /nix/var/nix/profiles/system

.PHONY: diff
diff: ## ↔️  Show changes between the current and previous generation
	nix store diff-closures /nix/var/nix/profiles/system-*-link /nix/var/nix/profiles/system

# ------------------------------------------------------------------------------
# Help
# ------------------------------------------------------------------------------

.PHONY: help
help: ## ✨ Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $1, $2}'

