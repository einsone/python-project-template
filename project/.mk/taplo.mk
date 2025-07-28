.PHONY: check-taplo ## 检查 taplo 是否安装
check-taplo:
	@taplo --version || echo "Install taplo by: `make install-taplo`"

.PHONY: install-taplo  ## 安装 taplo
install-taplo:
	@uv tool install taplo

.PHONY: update-taplo  ## 升级 taplo
update-taplo: check-taplo
	@uv tool upgrade taplo

.PHONY: config-taplo  ## 配置 taplo
config-taplo: check-taplo
	@if [ ! -f taplo.toml ]; then \
		echo "生成空 taplo.toml 文件 ..."; \
		touch taplo.toml; \
	fi

.PHONY: init-taplo  ## 初始化 taplo
init-taplo: config-taplo
	@echo "taplo 初始化完成"
