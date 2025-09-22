# 概要

このリポジトリをクローンして、`terraform apply` コマンドを実行することにより、AWS 上で Linux インスタンスおよび Windows インスタンスが起動します。

それらの EC2 インスタンスには、自動で Datadog Agent がインストールされます。

# 前提条件

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) をインストール済みであること。
- [Terraform](https://developer.hashicorp.com/terraform/install) をインストール済みであること。

# 事前準備

## terraform.tfvars ファイルの修正

- `creator` にご自身の名前を設定してください。
- こちらの[サイト](https://www.cman.jp/network/support/go_access.cgi)でグローバル IP アドレスを確認し、`your_global_ip_address` に設定してください。
- 事前に [EC2 のキーペアを作成](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/create-key-pairs.html)し、`key_pair_name` にそのキーペア名を設定してください。
- `dd_api_key` に Datadog の API キーを設定してください。

## AWS 認証情報の設定

- 以下ドキュメントのいずれかを参考に、AWS 認証情報を設定してください。
  - [Configure the AWS CLI with IAM Identity Center authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso)
  - [Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html?icmpid=docs_sso_user_portal)
  - [Configuration and credential file settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
  - [Authenticate with short-term credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-short-term.html)

# コマンド実行

このプロジェクトのルートディレクトリで以下のコマンドを実行してください。

1. `terraform init` （初回のみ）
1. `terraform apply`

# 動作確認

- こちらの [AWS ドキュメント](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html)を参考に、Linux インスタンスに SSH で接続してください。
- こちらの [AWS ドキュメント](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/connect-rdp.html)を参考に、Windows インスタンスに RDP で接続してください。
