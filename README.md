# Provision an Azure virtual machine instance
This Terraform configuration provisions a Linux virtual machine in Azure.

## Details
By default, this configuration will automatically provision the latest image of Ubuntu 18.04 with an instance type of Standard_B1ls in the "west central us" region.

Note that you need to be authenticated to Azure via the Azure CLI or create a service principal and set the environment variables ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID. If you do not have an ssh key to pass you can modify the code to set the use admin password and then under "os_profile_linux_config" change the "disable_password_authentication" to false.
