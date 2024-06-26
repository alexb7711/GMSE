################################################################################
# Variables
################################################################################

##==============================================================================
# Directories
ENV_DIR   = .venv
IMG_D     = img
UML_D     = uml
SRC_D     = src
TST_D     = test
NOSE_DIR  = $(ENV_DIR)/bin

##==============================================================================
# File Paths
DATA    = data
BIN     = $(ENV_DIR)/bin
DEP     = dependencies
PYTHON  = python

##==============================================================================
# Files
UML := $(patsubst %.puml, %.svg, $(wildcard $(UML_D)/*.puml))

##==============================================================================
# Makefile configuration
.PHONY: all setup install update run debug clean test help uml

################################################################################
# Recipes
################################################################################

##==============================================================================
#
all: setup update run ## Default action

##==============================================================================
#
test: ## Run unit tests
	@bash -c                    \
	"cd $(shell pwd)        &&  \
	source $(BIN)/activate  &&  \
	$(PYTHON) -m unittest discover -s $(TST_D) -p \"test_*.py\""

##==============================================================================
#
setup: ## Set up the project
	@# Set up virtual environemnt
	@$(PYTHON) -m venv $(ENV_DIR)
	@$(BIN)/pip install --upgrade pip
	@# Create output directories
	@mkdir -p $(DATA)
	@mkdir -p $(IMG_D)
	@# Intall packages into virtual environemnt
	@$(BIN)/pip install -r $(DEP)

##==============================================================================
#
update: ## Update the virtual environment packages
	@$(BIN)/pip install --upgrade pip
	@$(BIN)/pip install -r $(DEP)

##==============================================================================
#
run: ## Execute the program
	@bash -c                    \
	"cd $(shell pwd)        &&  \
	source $(BIN)/activate  &&  \
	cd $(SRC_D)             &&  \
	$(PYTHON) main.py"

##==============================================================================
#
uml: $(UML) ## Converts the UML files in $(UML_D) into SVG files

##==============================================================================
#
debug: ## Enable the debugger
	@echo Not implemented...

##==============================================================================
#
clean: ## Cleanup the project
	rm -rfv $(ENV_DIR)

##==============================================================================
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:  ## Auto-generated help menu
	@grep -P '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort                                                | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

################################################################################
# Generators
################################################################################

##==============================================================================
#
%.svg: %.puml ## Convert PUML files into SVG files
	@echo "Creating $@..."
	@plantuml -tsvg $<
