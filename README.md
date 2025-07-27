# 概要

このリポジトリをクローンして、`terraform apply` コマンドを実行することにより、AWS 上で Linux インスタンスおよび Windows インスタンスが起動します。

それらの EC2 インスタンスには、自動で Datadog Agent がインストールされます。

# 前提条件

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) をインストール済みであること。
- [Terraform](https://developer.hashicorp.com/terraform/install) をインストール済みであること。

# 事前準備

## terraform/terraform.tfvars　ファイルの修正

- `creator` にご自身の名前を設定してください。
- こちらの[サイト](https://www.cman.jp/network/support/go_access.cgi)でグローバル IP アドレスを確認し、`your_global_ip_address` にグローバル IP アドレスを設定してください。
- [事前に EC2 のキーペアを作成し](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/create-key-pairs.html)、`key_pair_name` にそのキーペア名を設定してください。
- `dd_api_key` に Datadog の API キーを設定してください。

## コマンド実行

- 初めての場合は、`terraform init` コマンドを実行してください。
- `terraform apply` コマンドを実行してください。
