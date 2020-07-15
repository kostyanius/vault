pkill vault

rm  -rf  *.zip.* *.zip

# This is the ABC installing Vault on AWS
# I am using a CentOS 7 EC2,
# I am following https://learn.hashicorp.com/vault/getting-started/install

wget https://releases.hashicorp.com/vault/1.5.0-rc/vault_1.5.0-rc_linux_amd64.zip

unzip vault_1.5.0-rc_linux_amd64.zip

sudo mv vault /bin/


# Start Vault server

/bin/vault server -dev >  ~/vault.log &

Unseal_Key=$(egrep -i "Unseal Key:" ~/vault.log)
Root_Token=$(egrep -i "Root Token:" ~/vault.log)

echo $Unseal_Key
echo $Root_Token
export VAULT_ADDR='http://127.0.0.1:8200'
echo $VAULT_ADDR

sleep 5

/bin/vault status


#aws_access_key_id=$(egrep -i "aws_access_key_id" ~/.aws/credentials | awk -F ' = ' '{print $2}')
#aws_secret_access_key=$(egrep -i "aws_secret_access_key" ~/.aws/credentials | awk -F ' = ' '{print $2}')

echo -e " \n"

read -p 'Enter aws_access_key_id: ' aws_access_key_id
read -p 'Enter aws_secret_access_key: ' aws_secret_access_key

vault kv put secret/id aws_access_key_id=$aws_access_key_id
vault kv put secret/key aws_secret_access_key=$aws_secret_access_key

vault kv get secret/id
vault kv get secret/key


