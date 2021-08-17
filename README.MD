HOMELAB-JELLYFIN-IMAGE
======

**Disclaimer**
This image provides a newer ffmpeg, intel-va-driver and vainfo from debian bullseye. This does not change anything on the jellyfin itself.

Due to the fact that INTEL NUCs of the 10th gen are not able to run any vaapi accelerated tasks with the current (10.7.6) image this dockerfile/image provides a patched version.

When using the jellyfin image you'll be run into this issue.

````
root@jellyfin-67bf84f4c7-ljwck:/dev/dri# vainfo
error: XDG_RUNTIME_DIR not set in the environment.
error: can't connect to X server!
libva info: VA-API version 1.10.0
libva info: Trying to open /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so
libva error: dlopen of /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so failed: /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so: undefined symbol: _ZN6GmmLib16GmmClientContext25CreateCustomResInfoObjectEP32GMM_RESCREATE_CUSTOM_PARA
MS__REC
libva info: va_openDriver() returns -1
libva info: Trying to open /usr/lib/x86_64-linux-gnu/dri/i965_drv_video.so
libva info: va_openDriver() returns -1
vaInitialize failed with error code -1 (unknown libva error),exit
root@jellyfin-67bf84f4c7-ljwck:/dev/dri# vainfo
error: XDG_RUNTIME_DIR not set in the environment.
error: can't connect to X server!
libva info: VA-API version 1.10.0
libva info: Trying to open /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so
libva error: dlopen of /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so failed: /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so: undefined symbol: _ZN6GmmLib16GmmClientContext25CreateCustomResInfoObjectEP32GMM_RESCREATE_CUSTOM_PARA
MS__REC
libva info: va_openDriver() returns -1
libva info: Trying to open /usr/lib/x86_64-linux-gnu/dri/i965_drv_video.so
libva info: va_openDriver() returns -1
vaInitialize failed with error code -1 (unknown libva error),exit
````
Ref: Issue on intel/libva #534 (https://github.com/intel/libva/issues/534)

