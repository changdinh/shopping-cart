#!/bin/bash

# Set variables
source "variables.sh"
Color_Running="\033[0;33m"
Color_Off="\033[0m"

echo "Starting..."



# Login to Azure Portal using username & PW
    # echo -e "\n ${Color_Running} Login to Azure Portal using Username/PW...${Color_Off}"
    # az login -u $user -p $pw

    # if [ $? != 0 ]
    # then
    #     echo -e "${Color_Err} ERROR! ${Color_Off}"
    # else
    #     echo "Success!"
    # fi



# Login to Azure Portal using username & PW
    echo -e "\n ${Color_Running} Login to Azure Portal using Service Principle...${Color_Off}"
    az login --service-principal --username $principle_ID --password $principle_PW --tenant $principle_tenant

    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi



# Create resource group
    # echo -e "\n\n${Color_Running} Creating Resource Group..."
    # az group create \
    #     -l $location \
    #     -n $CRName

    # if [ $? != 0 ]
    # then
    #     echo -e "${Color_Err} ERROR! ${Color_Off}"
    # else
    #     echo "Success!"
    # fi



# Create azure container registry
    echo -e "\n\n ${Color_Running} Creating Azure Container Registry...${Color_Off}"
    az acr create \
        -g $RGName \
        -n $CRName \
        --sku $sku \
        -l $location \
        --admin-enabled $acrAdmin # Enable the admin user for an existing registry

    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi



# Create azure container instance
    echo -e "\n\n ${Color_Running} Creating Container Instance...${Color_Off}"
    az container create \
        --name $aciName \
        -g $RGName \
        --image $image \
        --ip-address $ipAddress \
        --ports $port \
        --restart-policy $restartPolicy

    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi



# Create azure database
    echo -e "\n\n ${Color_Running} Creating Azure Database...${Color_Off}"

    az mysql server create \
        --resource-group $RGName \
        --name $mysqlName \
        --location $location \
        --admin-user $mysqlUser \
        --admin-password $mysqlPW

    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi


# Create Azure Data Lake Gen1
    echo -e "\n\n ${Color_Running} Creating Azure Data Lake Gen1...${Color_Off}"
    az dls account create \
        --account $dlsName \
        --resource-group $RGName \
        --location $locationDLS
    
    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi



# Create Azure AD Group
    echo -e "\n\n ${Color_Running} Creating Azure AD Group...${Color_Off}"
    az ad group create --display-name $AADGName \
        --mail-nickname $mailNickName
    
    if [ $? != 0 ]
    then
        echo -e "${Color_Err} ERROR! ${Color_Off}"
    else
        echo "Success!"
    fi

# Add members to AD Group
    echo -e "\n${Color_Running} Adding member to ADD Group...${Color_Off}"

    for i in ${arr_users[*]}
    do
        # Check whether the user existed or not
        result=$(az ad group member check --group $AADGName --member-id $i --query value)

        echo "User existence: $result"
        if [[ $result -eq false ]]
        then
            az ad group member add --group $AADGName \
            --member-id $i
            if [ $? != 0 ]
            then
                echo -e "${Color_Err} ERROR! ${Color_Off}"
            else
                echo "Added user with ID ${i} to ADD Group: ${AADGName}"
            fi
        else
            echo "User with ID ${i} already exists in ${AADGName} ADD Group"
        fi   
    done

# Create service principle

    # az ad sp create-for-rbac \
    #     --role="${principleRole}" \
    #     --scopes="/subscriptions/${subscriptionsID}" \
    #     --name $principleName
