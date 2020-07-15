
pkill vault
rm  -rf  *.zip.* *.zip

# This is the ABC installing Vault on AWS
# I am using a CentOS 7 EC2,
# I am following https://learn.hashicorp.com/vault/getting-started/install

wget https://releases.hashicorp.com/vault/1.5.0-rc/vault_1.5.0-rc_linux_amd64.zip

unzip vault_1.5.0-rc_linux_amd64.zip

sudo mv vault /bin/

## Install command-line completion
#/bin/vault -autocomplete-install
## Reload shell
#exec $SHELL


# Start Vault server


/bin/vault server -dev | tee ~/vault.log &

Unseal_Key=$(egrep -i "Unseal Key:" ~/vault.log)
Root_Token=$(egrep -i "Root Token:" ~/vault.log)

echo $Unseal_Key
echo $Root_Token
export VAULT_ADDR='http://127.0.0.1:8200'
echo $VAULT_ADDR
/bin/vault status

