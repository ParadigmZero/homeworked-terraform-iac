# Terraform installation

Developed with Terraform 1.7.3.

Guarantee compatibility with this version, or use another version at your discretion.

Example setup using brew package manager ( <brew.sh> ) - MacOs, Linux or Windows WSL:

`brew install tfenv`

Then:

`tfenv use`

# AWS CLI

Setup also assumes you have the `awscli` installed, based on the config and credentials files. If you have these files in the correct format, you could probably do without having the cli installed, however you may as well just install it, as overall it's simpler and quicker then trying to mimic the config files yourself. Again this can be installed from the brew package manager, or some other trusted package manager, or directly from Amazon. Example:

`brew install awscli`

Configure AWS, you will need to provide the `AWS Access Key ID` which you will be able to find on the console, and the `AWS Secret Access Key`. Note, the secret access key will be only be given once when you set up a key, so you must have that securely store/retrieve that yourself (e.g. with a trusted password manager).

`aws configure`

# Initialize

Initialize (first time only): 

`terraform init`

# Apply

To setup S3 bucket and associated objects, and to make changes from thereon enter:

`terraform apply`

( you will tend to mainly just use two commands in terraform, apply and plan)


