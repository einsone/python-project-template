# 本文件暴露的命令视为 Makefile 必须提供的接口。
# 工具（ruff/ty/taplo/codespell/prek）均来自 dev 依赖，统一通过 `uv run` 调用；
# 版本由 uv.lock 单一管理。CI 只需 `make sync` + `make check`。

.DEFAULT_GOAL := help

.PHONY: help ## 显示此帮助消息
help:
	@grep -E '^.PHONY: .*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ".PHONY: |## "}; {printf "\033[36m%-12s\033[0m %s\n", $$2, $$3}'

.PHONY: install-uv ## 安装 uv（仅本地 bootstrap；CI 请用官方 setup action）
install-uv:
	@curl -LsSf https://astral.sh/uv/install.sh | sh

.PHONY: sync ## 创建虚拟环境并安装依赖
sync:
	uv sync

.PHONY: hooks ## 安装 git 钩子
hooks:
	uv run prek install --install-hooks --overwrite

.PHONY: lint ## 代码检查
lint:
	uv run ruff check --fix

.PHONY: format ## 格式化代码
format:
	uv run ruff format
	@RUST_LOG=error uv run taplo format

.PHONY: typecheck ## 类型检查
typecheck:
	uv run ty check

.PHONY: test ## 运行测试
test:
	uv run pytest

.PHONY: test-cov ## 运行测试并生成覆盖率报告
test-cov:
	uv run pytest --cov --cov-report=term-missing

.PHONY: check ## 运行全部钩子（本地等价于 CI 闸门）
check:
	uv run prek run --all-files --show-diff-on-failure

.PHONY: clean ## 清理缓存文件
clean:
	rm -rf `find . -name __pycache__`
	rm -f `find . -type f -name '*.py[cod]'`
	rm -rf .pytest_cache .ruff_cache .mypy_cache dist
