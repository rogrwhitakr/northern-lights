
# Bypassing shell aliases
# alias ls='ls -Z'
ls
# only ls command
\ls

#execute on remote box
ssh srv 'bash -s' < ~/<path>/setup-profile-on-new-box.bash