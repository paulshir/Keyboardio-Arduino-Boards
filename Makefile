update-submodules: checkout-submodules
	@echo "All Kaleidoscope libraries have been updated from GitHub"

build-all: travis-test-all

travis-test-all: travis-install-arduino
	TRAVIS_ARDUINO_PATH=$(TRAVIS_ARDUINO_PATH) perl build-tools/test-recursively travis-test
	TRAVIS_ARDUINO_PATH=$(TRAVIS_ARDUINO_PATH) perl build-tools/test-recursively cpplint

checkout-submodules: git-pull
	git submodule update --init --recursive



maintainer-update-submodules:
	git submodule update --recursive --remote --init

git-pull:
	git pull

blindly-commit-updates: git-pull maintainer-update-submodules
	git commit -a -m 'Blindly pull all plugins up to current'
	git push


-include build-tools/makefiles/rules.mk
