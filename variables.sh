# Account info
user="changthi.dinh2@dxc.com"
pw="xxxx"

# Service Principle info
principle_ID="5a98931a-83d7-43fd-8aca-723cdc4abf92"
principle_PW="faG-I3fY8-we1.8PV2pmX5OPW4u59OB5q6"
principle_tenant="137e5a2f-32be-4811-b649-15bcce76b74f"


# Environment
env="dev"

# Variables often change
RGName="dma-rg-operation-global-${env}" # Resource group name
CRName="1dmacroperationglobal${env}" # Container registry name
aciName="1dma-aci-operation-global-${env}" # Azure container instance name
mysqlName="zma-sqldb-operation-global-${env}" # Azure database for Mysql name
mysqlUser="zwidssqldb"
mysqlPW="Login@pw1"
dlsName="1dlsoperationglobal${env}" # Azure data lake gen1 name
AADGName="1dma-sg-operation-global-${env}" # Azure AD Group name
AADMemberID1="0be7b7ad-4f61-41a6-bd31-e9662fd25cd2" # user: changthi.dinh2@dxc.com
AADMemberID2="bce555e1-c145-40ab-bfb0-1b453b93b3c5" # user: nchetry@dxc.com
AADMemberID3="2341d3e2-0f70-4627-92ad-ba6587bc9ac2" # user: ddang2@dxc.com
arr_users=($AADMemberID1 $AADMemberID2 $AADMemberID3)
principleName="dma-sp-operation-global-dev"
principleRole="Contributor"

# Variables rarely change
subscriptionsID="279adfe2-476c-490c-a1cf-be00be890369"
ipAddress="Public"
port="80"
restartPolicy="OnFailure"
location="eastus"
locationDLS="eastus2"
sku="Basic"
acrAdmin="true" # Enable the admin user for an existing registry
image="mcr.microsoft.com/azuredocs/aci-helloworld:latest"
mailNickName="NickName"

# Color
Color_Running="\033[0;33m"
Color_Off="\033[0m"
Color_Err="\033[0;31m" 
