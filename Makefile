mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

TYPO3_WEB_DIR := $(current_dir).Build/web
TYPO3_PATH_ROOT := $(current_dir).Build/web
# Allow different versions on travis
TYPO3_VERSION ?= ~8.7
typo3DatabaseName ?= "searchcoretwitter_test"
typo3DatabaseUsername ?= "dev"
typo3DatabasePassword ?= "dev"
typo3DatabaseHost ?= "127.0.0.1"

sourceOrDist=--prefer-dist
ifeq ($(TYPO3_VERSION),~7.6)
	sourceOrDist=--prefer-source
endif

.PHONY: install
install: clean
	if [ $(TYPO3_VERSION) = ~7.6 ]; then \
		patch composer.json Tests/InstallPatches/composer.json.patch; \
	fi

	COMPOSER_PROCESS_TIMEOUT=1000 composer require -vv --dev $(sourceOrDist) typo3/cms="$(TYPO3_VERSION)"
	git checkout composer.json

cgl:
	./.Build/bin/phpcs

unitTests:
	TYPO3_PATH_WEB=$(TYPO3_WEB_DIR) \
		.Build/bin/phpunit --colors --debug -v \
		-c Tests/Unit/UnitTests.xml

uploadCodeCoverage: uploadCodeCoverageToScrutinizer uploadCodeCoverageToCodacy

uploadCodeCoverageToScrutinizer:
	wget https://scrutinizer-ci.com/ocular.phar && \
	php ocular.phar code-coverage:upload --format=php-clover .Build/report/functional/clover/coverage

clean:
	rm -rf .Build composer.lock
