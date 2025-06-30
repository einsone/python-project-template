# Python 项目模板

## 使用

### 1. 安装依赖

```bash
# 安装 uv 包管理器
curl -LsSf https://astral.sh/uv/install.sh | sh

# 安装依赖
uv tool install copier
uv tool install pre-commit ruff
```

### 2. 初始化项目

```bash
copier copy --trust https://github.com/einsone/python-project-template.git path/to/destination
```

## 参考

- [![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)
- [![Copier](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/copier-org/copier/master/img/badge/badge-grayscale-inverted-border-orange.json)](https://github.com/copier-org/copier)
- <https://pre-commit.com/>
