# GroupSession Dockerコンテナ

[GroupSession](https://groupsession.jp/)（グループセッション）を簡単に構築できるDockerコンテナです。

[English version](README.md)

## 概要

このプロジェクトは、以下の環境でGroupSessionを提供します：
- **Java環境**: Temurin JDK 11 (Eclipse Adoptium)
- **アプリケーションサーバ**: Apache Tomcat 9
- **ローカライズ**: 日本語環境に最適化済み

## 前提条件

- DockerとDocker Composeがインストールされていること
- GroupSession WARファイル（[公式サイト](https://groupsession.jp/)からダウンロード）

## クイックスタート

1. **GroupSession WARファイルの取得**
   - [GroupSession公式サイト](https://groupsession.jp/)にアクセス
   - 最新版をダウンロード
   - ダウンロードしたファイルを`gsession.war`としてこのディレクトリに配置

2. **Dockerイメージのビルド**
   ```bash
   docker-compose build
   ```

3. **コンテナの起動**
   ```bash
   docker-compose up -d
   ```

4. **GroupSessionへのアクセス**
   - URL: http://localhost:8080/gsession/
   - 初期ログイン:
     - ユーザーID: `admin`
     - パスワード: `admin`

## 設定

### 環境設定
- **タイムゾーン**: Asia/Tokyo
- **ロケール**: ja_JP.UTF-8
- **文字エンコーディング**: UTF-8

### メモリ設定
デフォルトのJVMヒープ設定（`docker-compose.yml`で調整可能）：
- 最大ヒープサイズ: 2048MB
- 初期ヒープサイズ: 1024MB

### データの永続化
- GroupSessionのデータは`./gsession_data`ディレクトリに保存されます
- このディレクトリはコンテナ内の`/home/gsession`にマウントされます

## コンテナ管理

```bash
# コンテナの状態確認
docker-compose ps

# ログの表示
docker-compose logs -f groupsession

# コンテナの停止
docker-compose down

# コンテナの再起動
docker-compose restart
```

## ディレクトリ構成

```
.
├── Dockerfile          # コンテナイメージ定義
├── docker-compose.yml  # コンテナオーケストレーション
├── gsession.war       # GroupSession WARファイル（ユーザー提供）
├── gsdata.conf        # GroupSessionデータディレクトリ設定
├── startup.sh         # コンテナ起動スクリプト
└── gsession_data/     # 永続データディレクトリ（自動作成）
```

## トラブルシューティング

### よくある問題

- **コンテナ起動**: GroupSessionの完全な初期化には約20秒かかります
- **コンテナ再起動ループ**: `docker-compose logs groupsession`でログを確認してください - 通常は起動スクリプトの問題です
- **メモリ問題**: OutOfMemoryエラーが発生した場合は、`docker-compose.yml`の`JAVA_OPTS`を調整してください
- **接続拒否**: ホストのポート8080が他で使用されていないか確認してください
- **ロケール警告**: ログに表示されるロケール設定の警告メッセージは無害で、機能に影響しません

### デバッグコマンド

```bash
# コンテナの状態とヘルスチェック
docker-compose ps

# リアルタイムログの表示
docker-compose logs -f groupsession

# デバッグ用コンテナシェルアクセス
docker-compose exec groupsession bash

# GroupSessionの応答確認
curl -I http://localhost:8080/gsession/
```

## ライセンス

このDocker設定はMITライセンスで提供されています。GroupSession自体のライセンスについては[公式サイト](https://groupsession.jp/)をご確認ください。