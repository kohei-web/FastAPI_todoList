FROM python:3.12-slim

WORKDIR /src

# Pythonの出力をバッファリングしない（ログがすぐ見える）
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# 必要なLinuxパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Poetryをインストール
RUN pip install --upgrade pip \
    && pip install poetry

# アプリケーションコードをコピー
COPY . .

# ライブラリをインストール
RUN poetry install --no-root

# 起動コマンド（FastAPI + uvicorn）
CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
