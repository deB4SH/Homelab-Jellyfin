FROM docker.io/jellyfin/jellyfin:10.8.5
MAINTAINER deB4SH
#=====
# This is a temporary image until this issue is resolved inside the official jellyfin container
# * https://github.com/intel/libva/issues/534
#=====

#First: add unstable repos for newer libs/deps
RUN echo "deb http://deb.debian.org/debian/ testing main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian/ testing main contrib non-free" >> /etc/apt/sources.list
RUN apt update && apt install -y -t testing intel-media-va-driver-non-free vainfo ffmpeg
#Remove bundled ffmpeg
RUN rm -f /usr/local/lib/libigdgmm.so.11*