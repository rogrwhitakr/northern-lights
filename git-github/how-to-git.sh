# bin/sh

# variables
RED='\033[0;31m'
YELLOW='\e[33m'
NOC='\033[0m'
BLUE='\e[34m'

repository="${PWD%/*}"

demofile=demofile.txt

clear

echo -e "${RED}how-to-git${NOC}"

echo -e "git init"

echo -e "
		${YELLOW}initalizes an empty repository in `pwd` ${NOC}"

echo -e "git add <file(s)>"

echo -e "
		${YELLOW}adds file(s) to local repository ${NOC}"

echo -e "		adding file ${BLUE}$demofile ${NOC} to the local repository"

git add $demofile

echo -e "git status"

echo -e "
		${YELLOW}zeigt den status des lokalen repositories an, und aller Dateien darin ${NOC}"

git status

echo -e "${YELLOW}.gitignore${NOC}
		is used to leave files untracked in the repository
		gitignore ignores just files that weren't tracked before (by git add)
		to unstage the file:

git reset $demofile${NOC}
		
		Put .gitignore in the working directory. 
		It doesn't work if you put it in the .git (repository) directory."

echo -e "git commit ${BLUE}$demofile ${NOC} -m "commit message""

echo -e "
		${YELLOW}commits ${BLUE}$demofile ${YELLOW} to repository ${NOC}"

git commit $demofile

git remote add origin git@github.com:username/Some-Awesome-Project

git push origin master