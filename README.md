# Python Template

Python template using `uv` for project and `tox` for tests:

* formating and linting with `uv`, `ruff` and `mypy`
* testing with `uv` and `pytest`
* coverage
* documentation with `pdoc`
* building with `uv`

## Usage

Using make, a lot of commands are available:

* `sync`: install python version and sync uv dependencies
* `format`: format the coode using ruff
* `lint`: lint the code using ruff and mypy
* `test`: test the code using pytest
* `coverage`: generate a coverage report
* `docs`: generate html docs
* `live-docs`: generate live docs
* `build`: build the package
* `clean`: clean the repo

You can specify the python version using the env var `PYTHON_VERSION`.
