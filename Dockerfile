# 使用官方 Python 基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖（编译某些 Python 库时可能需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 升级 pip 并安装 JupyterLab 及常用数据科学库
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    jupyterlab \
    pandas \
    numpy \
    matplotlib \
    scikit-learn

# 暴露 JupyterLab 默认端口
EXPOSE 8888

# 启动 JupyterLab
# --ip=0.0.0.0: 允许所有 IP 访问
# --no-browser: 容器内不启动浏览器
# --allow-root: 允许以 root 用户运行
# --NotebookApp.token='': 禁用 Token 认证（本地开发方便，生产环境建议开启）
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
