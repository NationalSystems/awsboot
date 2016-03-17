
docker run --privileged -d -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/bin/docker -v /lib64/libsystemd-journal.so.0:/usr/lib/libsystemd-journal.so.0 -v /lib64/libsystemd-id128.so.0:/usr/lib/libsystemd-id128.so.0 -v /lib64/libdevmapper.so.1.02:/usr/lib/libdevmapper.so.1.02 -v /lib64/libgcrypt.so.11:/usr/lib/libgcrypt.so.11 -v /lib64/libdw.so.1:/usr/lib/libdw.so.1 -v /lib64/libudev.so.0:/usr/lib/libudev.so.0 -p 8080:8080 jenkins

