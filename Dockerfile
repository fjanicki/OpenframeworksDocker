# Start from the Ubuntu version you need, replace 'jammy' with the correct version if necessary
FROM ubuntu:22.04 as BUILDER

RUN apt-get update && apt-get install -y libunwind-dev wget tar software-properties-common make
ARG DEBIAN_FRONTEND=noninteractive

# Download and extract OpenFrameworks
WORKDIR /root

RUN wget https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_linux64gcc6_release.tar.gz
RUN tar -zxvf of_v0.11.2_linux64gcc6_release.tar.gz

WORKDIR /root/of_v0.11.2_linux64gcc6_release/scripts/linux/ubuntu
RUN ./install_dependencies.sh -y
RUN apt-cache show libgstreamer1.0-dev && GSTREAMER_VERSION=1.0
RUN apt-get install -y libmpg123-dev gstreamer1.0-plugins-ugly
#
## Build the OpenFrameworks libs
WORKDIR /root/of_v0.11.2_linux64gcc6_release/scripts/linux
RUN ./compileOF.sh -j4


FROM BUILDER as DEVELOP
# Copy your files here
# Build your project here
