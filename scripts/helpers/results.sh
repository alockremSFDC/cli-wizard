#!/bin/bash

function success() {

    # print a message in bold green.
    printf "%s\n\n" "${GREEN}${BOLD}Congratulations!${NORMAL}  Your dev org is ready to be used."
}

function failure() {

    # print a message in non-bold red.
    printf "%s\n\n" "${RED}Oops!  Something went wrong.${NORMAL}"
}

function confused() {

    # print a message in non-bold magenta.
    printf "\n%s\n\n" "${MAGENTA}I'm not sure what to do next.${NORMAL}  Ending the process without a successful result."
}