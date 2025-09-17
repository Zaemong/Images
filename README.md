# self-hosted-runner Dockerイメージ

このリポジトリは、GitHub ActionsのセルフホストランナーをDockerコンテナとして構築・運用するためのイメージを提供します。

## 構成ファイル
- `Dockerfile`: ランナーのセットアップと実行環境の構築
- `entrypoint.sh`: ランナーの登録・起動処理を自動化

## 使い方

### 1. ビルド
```bash
docker buildx build -t self-hosted-runner .
```

### 2. 実行
必要な環境変数（`URL`, `TOKEN`）を指定して起動します。

```bash
docker run -e URL="<GitHubリポジトリURL>" -e TOKEN="<登録用トークン>" self-hosted-runner
```

#### オプション環境変数
- `NAME`: ランナー名（省略可）
- `RUNNER_GROUP`: ランナーグループ（省略可）

### 3. 動作概要
- `.runner` ディレクトリが存在する場合は、登録済みとして `run.sh` のみ実行します。
- 未登録の場合は `config.sh` でランナー登録後、`run.sh` を実行します。

## 注意事項
- `URL` と `TOKEN` は必須です。未指定の場合は起動時にエラーとなります。
- LinuxベースのNode公式イメージ（`node:24-slim`）を利用しています。

## ライセンス
MIT
