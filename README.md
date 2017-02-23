# docker_challenge_hello_world
This is a repository with the source code for a [tiny docker image that prints "Docker Hello World!"](https://blog.hypriot.com/post/build-smallest-possible-docker-image/) assembled for ARM.
So far the image strips down to 169 Bytes :)
```bash
HypriotOS/armv6: pirate@hrrr in ~
$ docker run mpod/docker_challenge_hello_world:armhf
Hello Docker World!
HypriotOS/armv6: pirate@hrrr in ~
$ docker images mpod/docker_challenge_hello_world
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello_arm           armhf               8b612212faf3        7 hours ago         169 B
```

## Run the image


## Building
This image has to be built in two steps. First we need to assemble the .asm file to a working binary for ARM with the [fasmarm assembler](https://arm.flatassembler.net/). Unfortunately, this assembler does not run on ARM so we have to do assemble the code on a x86 machine. Once we have the binary built we can copy it over to an ARM machine and build the Docker image there.

### Step 1: Build the ARM binary
So log in to a x86 machine and install fasmarm:
```bash 
root@my-x86 in ~
$ mkdir fasmarm && \
cd fasmarm && \
wget https://arm.flatassembler.net/FASMARM_full.ZIP && \
unzip FASMARM_full.ZIP
```

Then build your ARM binary with: 
```bash
root@my-x86 in ~
$ fasmarm hello_arm.asm ~/hello_arm
```
### Step 2: Build the docker image
You have to copy the ARM binary built in Step 1 to an ARM machine and build the docker image there:
```bash
HypriotOS/armv6: pirate@hrrr in ~
$ docker build -t hello_arm -f Dockerfile.armhf .
```
And finally run it :
```bash
HypriotOS/armv6: pirate@hrrr in ~
$ docker run hello_arm
Hello Docker World!
```
