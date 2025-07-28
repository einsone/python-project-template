# 本文件暴漏的命令视为 makefile 必须提供的接口
# 如果切换其他包管理工具（比如 pdm），需要保证以下接口可用

.DEFAULT_GOAL := help

MAKEFILE_PATH := $(lastword $(MAKEFILE_LIST))
CURRENT_DIR := $(dir $(realpath $(MAKEFILE_PATH)))

include $(CURRENT_DIR)uv.mk
include $(CURRENT_DIR)pre-commit.mk
include $(CURRENT_DIR)ruff.mk
include $(CURRENT_DIR)taplo.mk

.PHONY: help ## 显示此帮助消息
help:
	@grep -E '^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ".PHONY: |## "}; {printf "\033[36m%-19s\033[0m %s\n", $$2, $$3}'

.PHONY: init ## 初始化开发环境
init: init-uv init-ruff init-pre-commit init-taplo
	@echo "项目初始化完成"

.PHONY: format ## 格式化代码
format: check-ruff
	@ruff format
	@RUST_LOG=error taplo format --config taplo.toml

.PHONY: lint ## ruff 代码检查
lint: check-ruff
	ruff check . --fix

.PHONY: pre-commit ## 运行 pre-commit
pre-commit: check-pre-commit
	pre-commit run --all-files --show-diff-on-failure

.PHONY: venv ## 创建虚拟环境
venv: uv-create-venv

.PHONY: python-shell ## 进入 Python shell
python-shell:
	@uv run python

.PHONY: clean ## 清理缓存文件
clean:
	rm -rf `find . -name __pycache__`
	rm -f `find . -type f -name '*.py[cod]'`
	rm -f `find . -type f -name '*~'`
	rm -f `find . -type f -name '.*~'`
	rm -rf .pytest_cache
	rm -rf .ruff_cache
	rm -rf .mypy_cache
