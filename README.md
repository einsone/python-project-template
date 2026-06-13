# Python 项目模板

基于 [copier](https://github.com/copier-org/copier) 的现代 Python 库项目模板，开箱集成 uv、ruff、ty、prek、pytest 等工具链。

## 特性

- **uv** —— 依赖管理、虚拟环境与打包，单一工具贯穿全流程
- **hatchling** —— 构建后端，标准纯 Python wheel
- **ruff** —— 代码检查与格式化（替代 black/isort/flake8）
- **ty** —— 极速类型检查（Astral 出品）
- **prek** —— Git 钩子管理（pre-commit 的 Rust 替代，零运行时依赖）
- **pytest** + **pytest-cov** —— 测试与覆盖率
- **taplo** —— TOML 格式化与检查
- **codespell** / **markdownlint** —— 拼写与 Markdown 检查
- **GitHub Actions** —— 跨 Python 3.11–3.13 的 CI

工具均作为开发依赖由项目管理（经 `uv run` 调用），版本由 `uv.lock` 统一锁定，无需全局安装。

## 使用

### 1. 安装 uv 与 copier

```bash
# 安装 uv 包管理器
curl -LsSf https://astral.sh/uv/install.sh | sh

# 安装 copier（仅用于生成项目）
uv tool install copier
```

### 2. 生成项目

```bash
copier copy --trust https://github.com/einsone/python-project-template.git path/to/destination
```

生成过程会自动执行 `make sync`（创建虚拟环境并安装依赖）与 `make hooks`（安装 Git 钩子），完成后即可开发。

### 3. 常用命令

进入生成的项目目录后：

```bash
make check   # 运行全部钩子（提交前必跑，等价于 CI 门禁）
make test    # 运行测试
make help    # 查看全部命令
```

> markdownlint 钩子需要本地具备 Node.js（prek 会自动安装 markdownlint-cli2 的隔离环境）。

## 参考

- [![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
- [![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)
- <https://docs.astral.sh/uv/>
- <https://prek.j178.dev/>
