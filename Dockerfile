FROM python:3.13

# 作業ディレクトリ
WORKDIR /code

# 依存関係ファイルをコピー
COPY requirements.txt /code/

# 依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# Node.js と npm をインストール（Tailwind 用）
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# プロジェクトをコピー
COPY /app/ /code/

