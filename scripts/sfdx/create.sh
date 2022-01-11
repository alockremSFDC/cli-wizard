#!/bin/bash

function confirmCreateNewOrg() {

    # present a message and wait for the response.
    while true; do

        # confirm if the user wants to create a new org.
        printf "%s" "${MSG_CONFIRM_CREATE_ORG}"                                                         # source: helpers/messages.sh
        
        # read the users response (yes or no).
        read -p " (y/n) " yn
        case $yn in

            # if the user responded yes create the new org.
            [Yy]* ) createNewOrg; break;;                                                               # ref: sfdx/create.sh
            
            # if the user responded no exit the app without knowing what to do.
            [Nn]* ) confused; break;;                                                                   # ref: helpers/results.sh
            
            # if the response was not yes or no ask the user to provide a valid answer.
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function createNewOrg() {

    # let the user know the org is being created in bold blue.
    printf "%s\n\n" "${BLUE}${BOLD}${MSG_CREATING_ORG}${NORMAL}"                                        # sources: helpers/fonts.sh, helpers/messages.sh
    
    # execute the sfdx command to create the scratch org.
    EXISTING_ORG=`sfdx force:org:create -f ./config/project-scratch-def.json --json | jq .result`
    
    # store the relevant values from the scratch org for future use.
    parseExistingOrgProperties                                                                          # ref: sfdx/get.sh 
    
    # print a confirmation message the org has been created.
    printf "%s\n\n" "${GREEN}${MSG_ORG_CREATED}${NORMAL}"                                               # sources: helpers/fonts.sh, helpers/messages.sh
    
    # set the new scratch org as the default username.
    setConfigDefaultUsername                                                                            # ref: sfdx/config.sh
    
    # ask the user if they would like the metadata to be deployed.
    confirmDeployMetadata                                                                               # ref: sfdx/deploy.sh
}