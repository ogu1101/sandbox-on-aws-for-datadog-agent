# AWS + Datadog Terraform Setup

## Introduction

This repository provides a Terraform configuration that automatically deploys both **Linux** and **Windows** EC2 instances on **AWS**, with the **Datadog Agent** installed and the **AWS–Datadog integration** configured automatically.

The setup is ideal for sandbox testing or training environments where quick provisioning and Datadog integration are required.

![architecture.png](architecture.png)

---

## Overview

When you clone this repository and run `terraform apply`, the following actions will occur automatically:

1. AWS EC2 instances (Linux and Windows) will be launched.  
2. Datadog Agents will be installed on each instance.  
3. The Datadog AWS integration will be configured.

---

## Prerequisites

Before you begin, ensure that the following tools are installed on your local environment:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
- [Terraform](https://developer.hashicorp.com/terraform/install)

---

## Setup Instructions

### 1. Update `terraform.tfvars`

Edit the `terraform.tfvars` file and update the following values:

- **`creator`** — Enter your name.  
- **`your_global_ip_address`** — Obtain your global IP address from [this site](https://www.cman.jp/network/support/go_access.cgi) and set it here.  
- **`key_pair_name`** — [Create an EC2 key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html) in advance and specify its name.  
- **`dd_api_key`** — Enter your Datadog API key.  
- **`dd_app_key`** — Enter your Datadog application key.  
- **`dd_integration_role`** — For Datadog employees, set `dd_integration_role` according to the naming convention described in [this guide](https://datadoghq.atlassian.net/wiki/spaces/TS/pages/346557463/AWS+Educational+Datadog+Sandbox+Account#Integrating-the-Sandbox).

---

### 2. Configure AWS Credentials

Configure your AWS credentials using one of the following methods:

- [Configure the AWS CLI with IAM Identity Center authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso)  
- [Use environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html?icmpid=docs_sso_user_portal)  
- [Set up configuration and credential files](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)  
- [Authenticate using short-term credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-short-term.html)

---

## Deployment

Run the following commands from the project’s root directory:

```bash
terraform init    # Run once during initial setup
terraform apply
```

Terraform will provision the AWS resources and automatically configure the Datadog integrations.

---

## Verification

After the deployment completes:

- Connect to the **Linux instance** via SSH using [this AWS guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html).  
- Connect to the **Windows instance** via RDP using [this AWS guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-rdp.html).

You should see the Datadog Agent running and metrics appearing in your Datadog dashboard shortly after deployment.

---

## Notes

- All resources are deployed to your own AWS account. Ensure that you have sufficient permissions and budget before applying changes.  
- Review the Terraform plan output carefully before proceeding to avoid unintended costs or configurations.  
- Datadog API and application keys are sensitive credentials — **never commit them to version control**.

---

## Disclaimer

This repository is intended for **educational and testing purposes only**.  
Do not use it in production environments without reviewing and adapting the configuration for security, compliance, and cost-management requirements.
