
#!/bin/bash
##
# This script will deploy to the SDN staging or production environment, after doing some work to tag commits and
#ensure that there are no diffs between current state and the upstream repo.
#
# This is how the syntax is constructed:
# ./predploy.sh [environment-to-deploy-to] [branch-to-deploy] [optional-variations]
#
# Here's an example of the syntax:
# ./predeploy.sh stage 2.17.2 withvars
#
# If there are no variations to deploy, the third option should be left blank.
#
#####################################################################################################################
# Begin script:
##

# Variables
DATE=$(date +%F" "%H:%M)
LOCBRANCH=$(git branch)
DIFF=$(git diff-index --name-only HEAD --)



# Halt if any line returns non-zero, and display output per-line during run.
#set -ex

# Exit if no arguments are passed on invocation.
if [  $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

# Checkout the requested branch if it does not exist locally.
if [[ "$LOCBRANCH" != *"$2"* ]]; then
	git checkout -t remotes/origin/release-$2
else
	git checkout release-$2
fi

# Check for uncommitted local changes.
if [[ -n "$DIFF" ]]; then
	echo "There are uncommitted local changes. Halting."
	exit 2
fi

# Deploy to staging environment.
if [[ $1 = "stage" ]]; then
	git tag -a $2 -m "tagged by predeploy.sh on $DATE"
fi

# Deploy to production environment.
if [[ $1 = "prod" ]]; then
	echo "placeholder for git merge $1 master"
	git tag -a $2 -m "tagged by predeploy.sh on $DATE"
fi

# Deploy variations if requested during invocation.
if [[ $3 = withvars ]]; then
	echo "placeholder for logic to also deploy the variations. WIP."
  case $1 in
    stage ) echo "this is for stage"
      ;;
    prod ) echo "this is for prod"
      ;;
  esac
fi
