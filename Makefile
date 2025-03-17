SRC_DIR = src/
TEST_DIR = tests/
UV_PYTHON ?= 3.11


.PHONY:sync
sync:
	uv python install $(PYTHON_VERSION)
	uv sync

.PHONY:format
format:
	uv run ruff format $(SRC_DIR) $(TEST_DIR)

.PHONY:fix
fix:
	uv run ruff check --fix $(SRC_DIR) $(TEST_DIR)

.PHONY:lint
lint:
	uv run ruff check $(SRC_DIR) $(TEST_DIR)
	uv run mypy $(SRC_DIR) $(TEST_DIR)

.PHONY:test
test:
	uv run coverage run -m pytest

.PHONY:run
run:
	uv run src/myapp/main.py

.PHONY:coverage
coverage:test
	-uv run coverage combine
	uv run coverage report
	uv run coverage xml
	uv run coverage html

.PHONY:docs
docs: clean-docs
	uv run pdoc -o docs/ src/myapp

.PHONY: live-docs
live-docs: clean-docs
	uv run pdoc src/myapp

.PHONY:build
build:
	uv build

.PHONY:clean
clean: clean-docs clean-coverage clean-build
	uv clean
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .ruff_cache
	rm -rf .venv

.PHONY:clean-docs
clean-docs:
	rm -rf docs/

.PHONY:clean-coverage
clean-coverage:
	rm -f .coverage*
	rm -f coverage.xml
	rm -rf htmlcov/

.PHONY:clean-build
clean-build:
	rm -rf dist
