.PHONY: check-pre-commit ## 检查 pre-commit 是否安装
check-pre-commit:
	@pre-commit --version || echo "install pre-commit by: `make install-pre-commit`"

.PHONY: install-pre-commit ## 安装 pre-commit
install-pre-commit:
	@uv tool install pre-commit

.PHONY: update-pre-commit ## 升级 pre-commit
update-pre-commit: check-pre-commit
	@uv tool upgrade pre-commit

.PHONY: init-pre-commit	## 初始化 pre-commit
init-pre-commit: check-pre-commit
	@pre-commit install --install-hooks --overwrite

.PHONY: update-hooks ## 升级 pre-commit hooks
update-pre-commit-hooks:
	@pre-commit autoupdate
