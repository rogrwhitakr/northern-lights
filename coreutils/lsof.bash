
# lsof - list open files
lsof -i

# from reddit
# Kill all processes listening on a certain port

port=8080
lsof -i :"${port}" | tail -n+2 | awk '{ print $2 }' | xargs kill

# also, does the same thing, more cleanly
fuser -k -SIGTERM "${port}"/tcp