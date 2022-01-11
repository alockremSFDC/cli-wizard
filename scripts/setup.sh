#!/bin/bash

# Import Salesforce DX actions
source ./scripts/sfdx/config.sh             # set default username to scratch org
source ./scripts/sfdx/create.sh             # create scratch org
source ./scripts/sfdx/delete.sh             # delete scratch org
source ./scripts/sfdx/deploy.sh             # deploy metadata to default org
source ./scripts/sfdx/get.sh                # get existing scratch org

# Import helpers
source ./scripts/helpers/app.sh             # application functions (welcome, execute)
source ./scripts/helpers/fonts.sh           # font manipulation (colors, bold)
source ./scripts/helpers/messages.sh        # output messages
source ./scripts/helpers/results.sh         # application results (success, error)

function main() {

    # display welcome message to the user
    welcome                                 # source: helpers/app.sh

    # execute the primary entry point for this application
    execute                                 # source: helpers/app.sh
}

# execute the main function of the script.
main