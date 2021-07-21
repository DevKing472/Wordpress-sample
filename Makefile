# Makefiles are traditionally for building C projects... Or something, IDK. Whatever.
# They're a great drop in for shared script runners, keeping cmd syntax brief.

# Declare a PHONY target, write the sequence of commands it executes, then chain them togehter.
# In your shell just run `make lint` to just run flake8 with the options listed.
# or run `make precommit` to run the lint target script and if it successfully exits then the test target script.

# List of phony make targets
.PHONY: test, lint, build, precommit, cli, gui

setup:
	pip install -r requirements.txt

# run flake8 with these params. E251 and E226 are errors about whitespace around operators.
lint:
	flake8 --ignore=E251,E226 --max-line-length=127

test:
	pytest

# lint and test and build the pypi package
build: lint test
	python -m build

# Run this. `make precommit`
precommit: lint test

cli:
	python -m tkdesigner.cli ${FIGMA_PROJECT_URL} ${FIGMA_TOKEN} -f

gui:
	python gui/gui.py