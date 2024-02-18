PYPI := https://pypi.tuna.tsinghua.edu.cn/simple

.PHONY: install-pdm  ## 使用 pip 安装 PDM
install-pdm:
ifeq (, $(shell which pdm))
	@echo "安装 pdm ..."
	pip install -i $(PYPI) pdm
PDM_BIN=$(shell which pdm)
else
	@echo "pdm 已安装"
PDM_BIN=$(shell which pdm)
endif

.PHONY: .pdm  ## 检查是否已安装 PDM
.pdm:
	@command -v pdm > /dev/null 2>&1 || { echo "PDM 未安装，请使用 'make install-pdm' 安装"; exit 1; }
	@pdm -V

.PHONY: update-pdm  ## 更新 PDM 到最新版本
update-pdm: .pdm
	@pdm self update

.PHONY: config-pdm  ## 配置 PDM
config-pdm: .pdm
	pdm config --local pypi.url $(PYPI)
	pdm config --local install.cache True
	pdm config --local pypi.verify_ssl False

.PHONY: create-venv  ## 创建项目内的虚拟环境（如已存在 .venv 目录则跳过）
create-venv: .pdm
	@if [ ! -d ".venv" ]; then \
		echo "准备虚拟环境 .venv ..."; \
		pdm venv create; \
		pdm use $(CURDIR)/.venv/bin/python; \
	else \
		pdm use $(CURDIR)/.venv/bin/python; \
		echo "重用已存在的 .venv"; \
	fi

.PHONY: remove-venv  ## 删除项目内的虚拟环境
remove-venv: .pdm
	pdm venv remove -y in-project

.PHONY: install-dev-dependencies
install-dev-dependencies: config-pdm create-venv
	pdm add -dG lint mypy ruff
	pdm add -dG test pytest
