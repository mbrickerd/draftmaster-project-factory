.PHONY: test docs

MODULES := $(wildcard components/*) $(wildcard terraform-bootstrap)

default: test

test:
	checkov --config-file=checkov.yaml
	terraform validate
	tflint --recursive
	terraform fmt -check --recursive

checkov:
	checkov --config-file=checkov.yaml

validate:
	terraform validate

format:
	terraform fmt --recursive

lint:
	tflint --recursive

docs:
	for d in $(MODULES); do \
		terraform-docs markdown $$d --output-file=README.md; \
    done