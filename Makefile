.PHONY:format lint clean clean-docs clean-coverage clean-dist test test-all run coverage coverage-all live-docs build-wheel

format:
	tox -p -e format

lint:
	tox -p -e lint

clean: clean-docs clean-coverage clean-dist
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '__pycache__' -exec rm -fr {} +
	rm -rf .tox/
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf venv

clean-docs:
	rm -rf docs/

clean-coverage:
	rm -f .coverage*
	rm -f coverage.xml
	rm -rf htmlcov/

clean-dist:
	rm -rf dist
	rm -rf build

test:
	tox -e py3

test-all:
	tox -p -e py3,py37,py38,py39,py310,py311

run: export PYTHONPATH = $(CURDIR)/src
run: setup
	. venv/bin/activate
	python src/myapp/main.py

coverage: clean-coverage
	tox -e py3,coverage

coverage-all: clean-coverage
	tox -p -e py3,py37,py38,py39,py310,py311
	tox -e coverage

docs: clean-docs
	tox -e docs

live-docs: clean-docs
	tox -e live-docs

sdist-wheel: clean-dist
	tox -e build -- --sdist

dist-wheel: clean-dist
	tox -e build -- --wheel

install: clean
	pip install .

venv/setup_done: requirements.txt
	test -d venv || python -m venv venv
	. venv/bin/activate
	pip install -r requirements.txt
	touch venv/setup_done

setup: venv/setup_done
