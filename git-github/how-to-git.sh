# bin/sh

clear
###################################################################################
# git github
###################################################################################

# find a repository in your ~
# have not tested what happens if there is more then one, probably will not work

return_to=`pwd`
cd $(find ~ -name .git) && cd ..

###################################################################################
# process
###################################################################################
# init
# git init initalizes an empty repository in `pwd`
echo -e "git init ."

# adding file(s) to local repository
echo -e "git add <file(s)>"

# get git status
# shows status of local repo, tracked,untreacked, changed, renamed file(s), etc.
echo -e "git status"

# .gitignore
# is used to leave files untracked in the repository 
# gitignore ignores just files that weren't tracked before (by git add)
# Put .gitignore in the working directory. 
# It doesn't work if you put it in the .git (repository) directory.

# unstaging a file: 
echo -e "git reset <file(s)>"
		
# committing file(s) to local master 
echo -e "git commit <file(s)> -m \"commit message\""

# adding a origin master to git config
# github example
echo -e "git remote add origin git@github.com:<github-user>/<repository-name>"

# pushing file(s) to origin master
echo -e "git push <repository-name>"

###################################################################################
# how to edit the git configuration
###################################################################################

# listing values
git config --list

# edit global values
echo -e "git config --global --edit"

# select yo editor
echo -e "git config --global core.editor nano"

###################################################################################
# how to handle the origin master
###################################################################################

# list remote repositories
echo -e "git remote show"

# list remote push / pull URLs
echo -e "git remote --verbose" 

echo -e "git remote add <repository-name> https://github.com/<github-user>/<repository-name>"

echo -e "git remote set-url <repository-name> git@github.com:<github-user>/<repository-name>.git"

echo -e "push --set-upstream <repository-name> master"

###################################################################################
# ho to connect to github
# https://help.github.com/articles/testing-your-ssh-connection/
###################################################################################

# Attempt to ssh to GitHub
echo -e "ssh -T git@github.com"

cd $return_to
exit 0