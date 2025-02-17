#!/bin/bash

##################################
# About : This .sh is used to find
#         the colaborators with access
#
# Input : Export your username token first then give the organisation name with repo name in cmd
#
# Output : You can view the users with access
#
# Date : 24th-Dec
#
# Owner : Navaneeethakrishnan M V
#
##################################

# GitHub API URL
API_URL="https://api.github.com"


# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

if [ $# -ne 2 ]; then
	echo "Error: You must provide exactly two argument."
	echo "Usage: ./list-users.sh REPO_OWNER REPO_NAME"
	exit 1
fi


# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}



# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
