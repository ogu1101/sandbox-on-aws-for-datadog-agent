resource "aws_instance" "linux" {
  ami                    = var.linux_ami
  instance_type          = var.linux_instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.linux.id
  vpc_security_group_ids = [aws_security_group.linux.id]

  user_data =  <<-EOF
    #!/bin/bash

    DD_API_KEY=${var.dd_api_key} \
    DD_SITE="datadoghq.com" \
    DD_APM_INSTRUMENTATION_ENABLED=host \
    DD_APPSEC_ENABLED=true \
    DD_REMOTE_UPDATES=true \
    DD_IAST_ENABLED=true \
    DD_APPSEC_SCA_ENABLED=true \
    DD_RUNTIME_SECURITY_CONFIG_ENABLED=true \
    DD_SBOM_CONTAINER_IMAGE_ENABLED=true \
    DD_SBOM_HOST_ENABLED=true \
    DD_APM_INSTRUMENTATION_LIBRARIES=java:1,python:3,js:5,php:1,dotnet:3 \
    bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"
  EOF
}

resource "aws_instance" "windows" {
  ami                    = var.windows_ami
  instance_type          = var.windows_instance_type
  key_name               = var.key_pair_name
  subnet_id              = aws_subnet.windows.id
  vpc_security_group_ids = [aws_security_group.windows.id]

  user_data_base64 = base64encode(<<-EOF
    <powershell>
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    $env:DD_API_KEY = '${var.dd_api_key}'
    $env:DD_SITE = 'datadoghq.com'
    $env:DD_REMOTE_UPDATES = 'true'
    $env:DD_APM_INSTRUMENTATION_ENABLED = 'iis'
    $env:DD_APM_INSTRUMENTATION_LIBRARIES = 'dotnet:3'
    (New-Object System.Net.WebClient).DownloadFile('https://install.datadoghq.com/Install-Datadog.ps1', 'C:\\Windows\\SystemTemp\\Install-Datadog.ps1')
    C:\\Windows\\SystemTemp\\Install-Datadog.ps1
    </powershell>
  EOF
  )
}
