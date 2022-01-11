#!/bin/bash

function confirmDeployMetadata() {

    # present a message and wait for the response.
    while true; do

        # confirm if the user wants to deploy the metadata to the scratch org.
        printf "%s" "${MSG_CONFIRM_DEPLOY_METADATA}"                                    # source: helpers/messages.sh
        
        # read the users response (yes or no).
        read -p " (y/n) " yn
        case $yn in
            
            # if the user responded yes deploy the metadata to the org.
            [Yy]* ) deployMetadata; break;;                                             # ref: sfdx/deploy.sh
            
            # if the user responded no exit the app without knowing what to do.
            [Nn]* ) confused; break;;                                                   # ref: helpers/results.sh
            
            # if the response was not yes or no ask the user to provide a valid answer.
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function deployMetadata() {
    
    # let the user know the metadata is being deployed.
    printf "%s\n\n" "${BLUE}${BOLD}${MSG_DEPLOYING_METADATA}${NORMAL}"                  # sources: helpers/fonts.sh, helpers/messages.sh
    
    # execute the sfdx command to deploy the metadata.
    DEPLOY_RESULT=`sfdx force:source:deploy -p ./force-app --json | jq .status`
    
    # print a confirmation message the metadata has been deployed.
    printf "%s\n\n" "${GREEN}${MSG_METADATA_DEPLOYED}${NORMAL}"                         # sources: helpers/fonts.sh, helpers/messages.sh
    
    # exit the application with a successful message.
    success                                                                             # source: helpers/results.sh
}