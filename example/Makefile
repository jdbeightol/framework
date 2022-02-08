INSTALL_DIR:=$(FRAMEWORK_LIB)
SOURCE_DIR:=./lib
DEST_FILES:=$(patsubst $(SOURCE_DIR)/%,$(INSTALL_DIR)/%,$(wildcard $(SOURCE_DIR)/*))

$(INSTALL_DIR):
	mkdir -p "$(INSTALL_DIR)"

$(INSTALL_DIR)/%.sh: $(SOURCE_DIR)/%.sh
	ln -v -s "$<" "$@"

install: $(DEST_FILES)
.PHONY: install
