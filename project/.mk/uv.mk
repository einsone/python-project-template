.PHONY: check-uv ## 检查 uv 是否安装
check-uv:
	@uv self version || echo "Install uv by `make install-uv`"

.PHONY: install-uv
install-uv: ## 安装 uv
	@curl -LsSf https://astral.sh/uv/install.sh | sh
	@echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
	@echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
	@echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
	@echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc

.PHONY: update-uv ## 更新 uv
update-uv:
	@uv self update

.PHONY: uninstall-uv ## 卸载 uv
uninstall-uv:
	@uv cache clean
	@rm -r "$(uv python dir)"
	@rm -r "$(uv tool dir)"
	@rm ~/.local/bin/uv ~/.local/bin/uvx

.PHONY: config-uv ## 配置 uv
config-uv:
	@if [ ! -f uv.toml ]; then \
		echo "生成 uv.toml 文件.."; \
		echo 'index-url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"' >> uv.toml; \
	fi

.PHONY: init-uv ## 初始化 uv
init-uv: config-uv

.PHONY: uv-create-venv ## 使用 uv 创建虚拟环境
uv-create-venv:
	@if [ ! -d .venv ]; then \
		echo "Creating virtual environment ..."; \
		uv venv; \
	else \
		echo "Virtual environment already exists."; \
	fi
