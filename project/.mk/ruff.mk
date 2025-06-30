.PHONY: check-ruff  ## 检查 ruff 是否安装
check-ruff:
	@ruff version || echo "Install uv by: `make install-ruff`"

.PHONY: install-ruff  ## 安装 ruff
install-ruff:
	@uv tool install ruff

.PHONY: update-ruff  ## 升级 ruff
update-ruff: check-ruff
	@uv tool upgrade ruff

.PHONY: config-ruff  ## 配置 ruff
config-ruff: check-ruff
	@if [ ! -f ruff.toml ]; then \
		echo "生成空 ruff.toml 文件 ..."; \
		touch ruff.toml
	fi

.PHONY: init-ruff  ## 初始化 ruff
init-ruff: config-ruff
