PYPI := https://pypi.tuna.tsinghua.edu.cn/simple some-package

.PHONY: install-pre-commit  ## 使用 pip 安装 pre-commit
install-pre-commit:
ifeq (, $(shell which pre-commit))
	@echo "安装 pre-commit ..."
	pip install -i $(PYPI) pre-commit
PRE_COMMIT_BIN=$(shell which pre-commit)
else
	@echo "pre-commit 已安装"
PRE_COMMIT_BIN=$(shell which pre-commit)
endif

.PHONY: .pre-commit  ## 检查是否已安装 pre-commit
.pre-commit:
	@command -v pre-commit > /dev/null 2>&1 || { echo "pre-commit 未安装，请使用 'make install-pre-commit' 安装"; exit 1; }
	@pre-commit -V

.PHONY: pre-commit-install  ## 初始化 pre-commit
pre-commit-install: .pre-commit
	pre-commit install --install-hooks --overwrite

.PHONY: pre-commit-update-hooks  ## 升级 pre-commit hooks 至最新版
pre-commit-update-hooks: pre-commit-install
	pre-commit autoupdate

.PHONY: pre-commit  ## 运行 pre-commit
pre-commit: pre-commit-install
	pre-commit run --all-files
