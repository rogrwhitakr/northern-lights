
# how to talk to DBus

```
busctl

# see the tree of an element
busctl tree postgresql
busctl tree org.freedesktop.machine1

# see the details of an element
busctl introspect org.freedesktop.machine1

# see methods and properties of a leaf
busctl introspect org.freedesktop.machine1  /org/freedesktop/machine1/machine/qemu_2d1_2dIAV_2eMagellan 
```