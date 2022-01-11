#!/bin/bash

function welcome() {

    # print the app started title message.
    printf "\n%s\n" "${YELLOW}${BOLD}${MSG_APP_STARTED_TITLE}${NORMAL}"     # sources: helpers/fonts.sh, helpers/messages.sh

    # display the app started subtitle.
    printf "%s\n\n" "${MSG_APP_STARTED_SUBTITLE}"                           # sources: helpers/fonts.sh, helpers/messages.sh
}

function execute() {

    # attempt to find an existing scratch org.
    getExistingOrg                                                          # ref: sfdx/get.sh

    # react differently depending on if the scratch org exists.
    if [ -z "$EXISTING_ORG" ]; then                                         # -z checks for null/empty

        # execute the script dedicated to no scratch org found.
        noExistingOrgFound                                                  # ref: sfdx/get.sh
    
    # if a scratch org was found:
    else                                                                    

        # confirm the user wants to use the existing scratch org.
        confirmUseExistingOrg                                               # ref: sfdx/get.sh
    fi
}