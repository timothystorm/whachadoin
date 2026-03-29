# WachaDoin  Development Task Runner (using just - https://github.com/casey/just)
#
# This file contains ALL development commands.
# CI uses make (see makefile for CI-only commands).
#
# Install: brew install just (macOS) or cargo install just
# Usage: just <task>
# List all tasks: just --list

# Default recipe (runs when you type `just`)
default:
    @just --list

# -----------------------------------------------------------------------------
# Setup & Installation
# -----------------------------------------------------------------------------

# Initial project setup (run once) - installs everything you need
setup:
  @echo "🏗️ Setting up WachaDoin workspace..." 
  uv lock
  uv sync

# -----------------------------------------------------------------------------
# Development
# -----------------------------------------------------------------------------
port := '8000'

# Start development server - auto-reload enabled
dev port=port:
  @echo "🚀 Starting development server on port {{port}}..."
  uv run fastapi dev --reload-dir . --reload-dir {{justfile_directory()}}/src/api --host 0.0.0.0 --port {{port}} 

# Start production server
prod port=port:
  @echo "🚀 Starting production server on port {{port}}..."
  uv run fastapi run --host 0.0.0.0 --port {{port}} 

# -----------------------------------------------------------------------------
# Testing
# -----------------------------------------------------------------------------

test:
  uv run pytest {{justfile_directory()}}/src/api

test-cov:
  uv run pytest --cov=src --cov=api --cov-report=term-missing --cov-report=html

# -----------------------------------------------------------------------------
# Cleanup
# -----------------------------------------------------------------------------

# Clean build artifacts and cache
clean:
    @echo "🧼 Cleaning workspace..."
    @find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    @find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
    @find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
    @find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
    @find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
    @find . -type f -name "*.pyc" -delete 2>/dev/null || true
    @echo "✨ Clean!"

# Deep clean (includes venv)
clean-all: clean
    @echo "🧹 Deep cleaning (including venv)..."
    rm -rf .venv
    @echo "✨ Squeaky clean! Run 'just setup' to reinstall"
