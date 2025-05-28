# problem with the non-version kernel

```sh
# -> shows a f39 kernel running despite having f40 installed
uname -ar

# remove the efi configs
sudo rm -fr /boot/efi/

# reinstall the kernel (incl headers et al)
sudo dnf reinstall kernel*
```


```sh
# list all installed kernels
sudo rpm -qa kernel
# or
sudo dnf list installed kernel 

```