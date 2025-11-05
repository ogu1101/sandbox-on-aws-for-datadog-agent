# AWS + Datadog Terraform Demo

## Introduction

This repository provides a Terraform configuration to automatically deploy both **Linux** and **Windows** EC2 instances on **AWS**, with **Datadog Agent** installation and **AWS–Datadog integration** handled automatically.

The setup is ideal for demonstration, sandbox testing, or training environments where quick provisioning and Datadog integration are required.

![architecture.png](architecture.png)

---

## Overview

When you clone this repository and execute `terraform apply`, the following will happen automatically:

1. AWS EC2 instances (Linux and Windows) will be launched.  
2. Datadog Agents will be installed on each instance.  
3. The Datadog AWS integration will be configured.

---

## Prerequisites

Ensure that the following tools are installed on your system before proceeding:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
- [Terraform](https://developer.hashicorp.com/terraform/install)

---

## Setup Instructions

### 1. Update `terraform.tfvars`

Edit the `terraform.tfvars` file and update the following values:

- **`creator`** — Set your name.  
- **`your_global_ip_address`** — Obtain your global IP from [this site](https://www.cman.jp/network/support/go_access.cgi).  
- **`key_pair_name`** — [Create an EC2 key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html) beforehand and specify its name here.  
- **`dd_api_key`** — Your Datadog API key.  
- **`dd_app_key`** — Your Datadog Application key.  
- **`dd_integration_role`** — If you are a Datadog employee, follow [this guide](https://datadoghq.atlassian.net/wiki/spaces/TS/pages/346557463/AWS+Educational+Datadog+Sandbox+Account#Integrating-the-Sandbox) to configure the appropriate role.

---

### 2. Configure AWS Credentials

Set up AWS credentials using one of the following methods:

- [Configure the AWS CLI with IAM Identity Center authentication](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html#sso-configure-profile-token-auto-sso)  
- [Use environment variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html?icmpid=docs_sso_user_portal)  
- [Set up configuration and credential files](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)  
- [Authenticate using short-term credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-short-term.html)

---

## Deployment

Run the following commands in the project’s root directory:

```bash
terraform init    # Run only once, during initial setup
terraform apply
```

Terraform will then provision the AWS resources and automatically configure Datadog integrations.

---

## Verification

Once the deployment completes:

- Connect to the **Linux instance** via SSH following [this AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-ssh.html).  
- Connect to the **Windows instance** via RDP following [this AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-rdp.html).

You should see the Datadog Agent running and metrics flowing into your Datadog dashboard shortly after deployment.

---

## Notes

- All resources are deployed under your AWS account; please ensure you have the necessary permissions and budget.  
- Review the Terraform plan carefully before applying changes to avoid unintended costs or configurations.  
- Datadog API and Application keys are sensitive credentials — **do not commit them to version control**.

---

## Disclaimer

This repository is intended for **educational and demonstration purposes only**.  
Do not use it in production environments without reviewing and adapting the configuration for security, compliance, and cost-management requirements.
