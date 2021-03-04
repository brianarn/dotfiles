.PHONY: install
install: init-submodules main-install post-update

.PHONY: update
update: submodule-update post-update

.PHONY: main-install
main-install:
	./bin/bs-dot-install.sh

.PHONY: init-submodules
init-submodules:
	./bin/bs-dot-init-submodules.sh

.PHONY: submodule-update
submodule-update:
	./bin/bs-dot-update-submodules.sh

.PHONY: post-update
post-update:
	./bin/bs-dot-post-update.sh
