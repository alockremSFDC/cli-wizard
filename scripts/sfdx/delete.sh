#!/bin/bash

function confirmDeleteExistingOrg() {

    # present a message and wait for the response.
    while true; do

        # confirm if the user wants to delete the existing scratch org.
        printf "%s" "${RED}${MSG_CONFIRM_DELETE_EXISTING_ORG}${NORMAL}"         # sources: helpers/fonts.sh, helpers/messages.sh
        
        # read the users response (yes or no).
        read -p " (y/n) " yn
        case $yn in
            
            ## if the user responded yes delete the existing org.
            [Yy]* ) deleteExistingOrg; break;;                                  # ref: sfdx/delete.sh
            
            # if the user responded no exit the app without knowing what to do.
            [Nn]* ) confused; break;;                                           # ref: helpers/results.sh
            
            # if the response was not yes or no ask the user to provide a valid answer.
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function deleteExistingOrg() {
    
    # let the user know the org is being deleted in bold blue.
    printf "%s\n\n" "${BLUE}${BOLD}${MSG_DELETING_ORG}${NORMAL}"                # sources: helpers/fonts.sh, helpers/messages.sh
    
    # execute the sfdx command to delete the existing scratch org.
    DELETE_RESULT=`sfdx force:org:delete -u $EXISTING_USERNAME -p`              # source: sfdx/get.sh
    
    # print a confirmation message the org has been deleted.
    printf "%s\n\n" "${GREEN}${MSG_ORG_DELETED}${NORMAL}"                       # sources: helpers/fonts.sh, helpers/messages.sh
    
    # confirm if the user wants to create a new org.
    confirmCreateNewOrg                                                         # ref: sfdx/create.sh
}