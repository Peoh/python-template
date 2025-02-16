SRC_DIR = src/
TEST_DIR = tests/
PYTHON_VERSION ?= 3.11

UV_RUN=uv run --python $(PYTHON_VERSION)

.PHONY:sync
sync:
	uv python install $(PYTHON_VERSION)
	uv sync

.PHONY:format
format: sync
	uv lock
	$(UV_RUN) ruff format $(SRC_DIR) $(TEST_DIR)

.PHONY:fix
fix: sync
	$(UV_RUN) ruff check --fix $(SRC_DIR) $(TEST_DIR)
	$(UV_RUN) mypy $(SRC_DIR) $(TEST_DIR)

.PHONY:lint
lint: sync
	$(UV_RUN) ruff check --fix $(SRC_DIR) $(TEST_DIR)
	$(UV_RUN) mypy $(SRC_DIR) $(TEST_DIR)

.PHONY:test
test: sync
	$(UV_RUN) coverage run -m pytest

.PHONY:run
run: sync
	$(UV_RUN) src/myapp/main.py

.PHONY:coverage
coverage: test
	-$(UV_RUN) coverage combine
	$(UV_RUN) coverage report
	$(UV_RUN) coverage xml
	$(UV_RUN) coverage html

.PHONY:docs
docs: clean-docs
	$(UV_RUN) pdoc -o docs/ src/myapp

.PHONY: live-docs
live-docs: clean-docs
	$(UV_RUN) pdoc src/myapp

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
