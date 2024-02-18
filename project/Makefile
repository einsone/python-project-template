MAKEFILE_PATH := $(lastword $(MAKEFILE_LIST))
CURRENT_DIR := $(dir $(realpath $(MAKEFILE_PATH)))
SHELL := bash

include $(CURRENT_DIR)/.mk/*.mk

.PHONY: init  ## 项目初始化
init: install-dev-dependencies pre-commit-install
	@echo "项目初始化完成"

.PHONY: help  ## 显示此帮助消息
help:
	@grep -E \
		'^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ".PHONY: |## "}; {printf "\033[36m%-25s\033[0m %s\n", $$2, $$3}'
