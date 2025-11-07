FROM python:3.13

# 作業ディレクトリ
WORKDIR /code

# Node.js, curl, MariaDB Client, Java, Graphviz, PlantUML
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl mariadb-client openjdk-21-jre graphviz wget && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g npm@latest && \
    wget https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar -O /usr/local/bin/plantuml.jar && \
    chmod +x /usr/local/bin/plantuml.jar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Python 依存関係ファイルをコピー
COPY requirements.txt /code/

# Python 依存関係インストール
RUN pip install --no-cache-dir -r requirements.txt

ENV PLANTUML_JAR=/usr/local/bin/plantuml.jar

# プロジェクトをコピー
COPY /app/ /code/