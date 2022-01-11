#!/bin/bash

function getExistingOrg() {

    # let the user know the application is searching for an existin scratch org.
    printf "%s\n\n" "${BLUE}${BOLD}${MSG_ORG_SEARCHING}${NORMAL}"                           # sources: helpers/fonts.sh, helpers/messages.sh
    
    # execute the sfdx command to searchfor an existing scratch org.
    EXISTING_ORG=`sfdx force:org:list --json | jq -e ".result.scratchOrgs[0] // empty"`
    
    # store the relevant values from the scratch org for future use.
    parseExistingOrgProperties                                                              # ref: sfdx/get.sh (self)
}

function parseExistingOrgProperties() {
    
    # only execute if the existing org has been found.
    if [ ! -z "$EXISTING_ORG" ]                                                             # -z checks for null/empty
    then
        
        # set the existing username and expiration date as variables.
        EXISTING_USERNAME=`echo $EXISTING_ORG | jq -r .username`                            # source: sfdx/get.sh (self)
        EXISTING_EXPIRATION_DATE=`echo $EXISTING_ORG | jq -r .expirationDate`               # source: sfdx/get.sh (self)
    fi
}

function noExistingOrgFound() {
    
    # let the user know a scratch org was not found.
    printf "%s\n\n" "${RED}${MSG_NO_ORG_FOUND}${NORMAL}"                                    # sources: helpers/fonts.sh, helpers/messages.sh
    
    # confirm if the user wants to create a new org.
    confirmCreateNewOrg                                                                     # ref: sfdx/create.sh
}

function confirmUseExistingOrg() {
        
    # present a message and wait for the response.
    while true; do

        # let the user know a scratch org was not found.
        printf "%s\n\n" "${GREEN}${MSG_ORG_FOUND}${NORMAL}"                                 # sources: helpers/fonts.sh, helpers/messages.sh

        # display the details of the existing scratch org.
        printExistingOrgDetails                                                             # ref: sfdx/get.sh (self)
        
        # ask the user if they would like to use the existing org.
        printf "%s" "${MSG_CONFIRM_USE_EXISTING_ORG}"
        
        # read the users response (yes or no).
        read -p " (y/n) " yn
        case $yn in
            
            # if the user responded yes set the default username and confirm
            # if the user wants to deploy the metadata to this org.
            [Yy]* ) setConfigDefaultUsername; confirmDeployMetadata; break;;                # refs: sfdx/config.sh, sfdx/deploy.sh
            
            # if the user responded no confirm if they want to delete the existing org.
            [Nn]* ) confirmDeleteExistingOrg; break;;                                       # ref: sfdx/delete.sh
            
            # if the response was not yes or no ask the user to provide a valid answer.
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function printExistingOrgDetails() {
        
    # display the username and expiration date of the existing org.
    printf "%s\n" "Username: ${YELLOW}${EXISTING_USERNAME}${NORMAL}"                    # sources: helpers/fonts.sh, helpers/messages.sh
    printf "%s\n\n" "Expiration Date: ${YELLOW}${EXISTING_EXPIRATION_DATE}${NORMAL}"    # sources: helpers/fonts.sh, helpers/messages.sh
}