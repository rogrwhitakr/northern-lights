#! /bin/sh

echo -e "Fix for VirtualBox Guest Additions failed install"

# we need to install @devel tools (kernel make)
sudo dnf install @Development


# get kernel version with uname
uname -r
export KERN_DIR = /usr/src/kernels/$(uname -r)

# we then mount the Guest Additions, check df to see mountpoint
df
cd mountpoint
./VirtualBox.run