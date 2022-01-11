#!/bin/bash

function setConfigDefaultUsername() {

    # print the message associated with setting the default username in blue.
    printf "%s\n\n" "${BLUE}${BOLD}${MSG_SETTING_DEFAULT_USERNAME}${NORMAL}"                            # sources: helpers/fonts.sh, helpers/messages.sh

    # execute the sfdx command to set the default username.
    CONFIG_RESULT=`sfdx force:config:set defaultusername=${EXISTING_USERNAME} --json | jq .result`      # source: sfdx/get.sh

    # display a confirmation message that the default username has been set.
    printf "%s\n\n" "${GREEN}${MSG_DEFAULT_USERNAME_SET}${NORMAL}"                                      # sources: helpers/fonts.sh, helpers/messages.sh
}
