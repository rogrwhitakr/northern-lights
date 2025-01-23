#
# bash command line stuffs
#


# substitute in the last argument of the last command into your line.
!$

# subsitute any command in order
!:n

# if command is something like, you can rearrange like so
tar -cvf archive.tar <decompressed_archive>

!:0 !:1 !:3 !:2
