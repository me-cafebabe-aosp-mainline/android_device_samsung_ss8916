# Android device tree for Samsung MSM8916 devices running mainline kernel

## Partition layout

| Partition | Size | Content | Image |
|-----------|------|---------|-------|
| `boot` | 13 MiB | lk2nd | `lk2nd.img` |
| `cache` | 30 MiB | ext2: kernel, ramdisk, DTBs, `extlinux/extlinux.conf` | `ss8916-cache.img` |
| `userdata` | > 4 GiB | f2fs: `android/{system,vendor,vendor_dlkm}.img`, `android/metadata/`, `android/userdata/` | `ss8916-userdata.img` |

## Building and flashing

```
m ss8916-images
cd $OUT && fastboot flashall
```

`ss8916-cacheimage` and `ss8916-userdataimage` build the single images.
`ss8916-images-nodeps` (or `ss8916-cacheimage-nodeps` and
`ss8916-userdataimage-nodeps`) repacks the images from what is already
built, without checking dependencies. It is useful after temporary edits
to the files in `$OUT`.

The userdata image is 4 GiB; change it with `SS8916_USERDATA_IMAGE_SIZE`
(bytes) if the partition is smaller.
