FROM python:3.13

# 作業ディレクトリ
WORKDIR /code

# 依存関係ファイルをコピー
COPY requirements.txt /code/

# Node.js と npm をインストール（Tailwind 用）
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Tailwind CSS と Alpine.js をインストール
RUN npm install -D tailwindcss @tailwindcss/cli postcss autoprefixer && npm install alpinejs

# Python依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# プロジェクトをコピー（Tailwindをビルドするために必要なファイルも含む）
COPY . .

# Tailwind CSS をビルド（CLIのパスを明示）
RUN npx @tailwindcss/cli -i app/static/style.css -o app/static/output.css