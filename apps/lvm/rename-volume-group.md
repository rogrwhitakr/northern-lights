# rename colume group

1. rename is easy, the problem is with the kernel boot options
2. initramfs must be rewritten to reflect the changnes in name, otherwise the kernel will not find the file descriptor for the bootable device
3. on fedora this is done via dracut

```sh
sudo dracut --regenerate-all --force 
```

4. after this, the rename should be complete
5. todo -> han i name the cg what i want, or do I need to follow some naming schema?