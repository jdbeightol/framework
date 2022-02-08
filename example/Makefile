INSTALL_DIR:=$(FRAMEWORK_LIB)
LIB_DIR:=$(PWD)/lib
LIB_FILES:=$(patsubst $(LIB_DIR)/%,$(INSTALL_DIR)/%,$(wildcard $(LIB_DIR)/*))

$(INSTALL_DIR):
	mkdir -p "$(INSTALL_DIR)"

$(INSTALL_DIR)/%.sh: $(LIB_DIR)/%.sh
	@cp -v "$<" "$@"

install: $(LIB_FILES)
.PHONY: install

uninstall:
	rm -vf $(LIB_FILES)
.PHONY: uninstall

test-env: export PS1:=test-env> 
test-env: export FRAMEWORK_LIB:=$(LIB_DIR)
test-env: export PATH:=$(PWD):$(PATH)
test-env:
	@echo "opening a new shell with custom environment, ctrl+d or exit to close"
	@bash --noprofile --norc
.PHONY: test-env
