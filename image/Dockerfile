#FROM arm32v7/debian:stretch-slim
FROM arm32v7/debian:bullseye-slim

# Environment Variable
ENV DEBIAN_FRONTEND=noninteractive
ENV MISTER_ROOT=/mister

# Switches for Optimization
#ENV CFLAGS="-mfloat-abi=hard -march=armv7-a -mfpu=neon"
#ENV CXXFLAGS="-mfloat-abi=hard -march=armv7-a -mfpu=neon"
ENV MAKEFLAGS="-j$(nproc)"

# Core Developement Packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	autoconf \
	automake \
	bash-completion \
	bison \
	build-essential \
	ca-certificates \
	checkinstall \
        cmake \
	curl \
	flex \
	gdb \
	git \
	gperf \
	iputils-ping \
	less \
	libc-dev \
	libcurl4-openssl-dev \
	libdjvulibre-dev \
	libelf-dev \
	libexpat-dev \
	libfreetype6-dev \
	liblcms2-dev \
	libgmp3-dev \
	libharfbuzz-dev \
	libjbig2dec0-dev \
	libjsoncpp-dev \
	liblz4-tool \
	libmpc-dev \
	libmpfr-dev \
 	libmupdf-dev \
	#libncurses5-dev \
	libpcap-dev \
	libpng-dev \
	libpoppler-cpp-dev \
	libreadline-dev \
	libssl-dev \
	libtiff-dev \
	libz-dev \
	libtcmalloc-minimal4 \
	libtool \
	libtool-bin \
	libusb-dev \
	libusb-1.0-0-dev \
	locales \
	mlocate \
	mupdf \
	nano \
	nasm \
	openssh-client \
	p7zip \
	python3-pip \
	pkg-config \
	software-properties-common \
	sshpass \
	sudo \
	tcl \
	texinfo \
	tree \
	unzip \
        vim \
	wget \
	xz-utils \
	zlib1g-dev \
	--no-install-recommends && \
	## Make sure we leave any X11 related library behind
	apt-get purge -y 'libx11*' x11-common libxt6 && \
	apt autoremove -y && \
	rm -r /var/lib/apt/lists/*

# Compilers Envoirment Shortcuts.
ENV AS=as \
    AR=ar \
    CC=gcc \
    CPP=cpp \
    CXX=g++ \
    LD=ld \
    FC=gfortran

# Set System Locales
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV export LANG en_US.UTF-8
ENV export LANGUAGE en_US:en
ENV export LC_ALL en_US.UTF-8

# Base Directories
RUN mkdir -p "${MISTER_ROOT}"  && \
	chmod -R 777 "$MISTER_ROOT" 


# Fix some core dependencies without rebuilding all layers
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y gettext libglib2.0-dev \
	libltdl-dev autopoint libudev-dev udev \
	libdbus-1-dev libdbus-glib-1-dev intltool \
	autogen shtool \
	--no-install-recommends && \
	rm -r /var/lib/apt/lists/*

# Add CXXFLAGS

# Set Volume and Workdir
VOLUME /mister
WORKDIR /mister

# Bash Settings
RUN echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> ~/.bashrc && \
    echo "export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;33m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]\$ '" >> ~/.bashrc && \
    echo "alias ll='ls -lah'" >> ~/.bashrc && \
    echo "alias ls='ls --color=auto'" >> ~/.bashrc

# Metadata Params
ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

# Metadata
LABEL \
	org.label-schema.schema-version="1.0" \
	org.label-schema.vendor="alanswx" \
	org.label-schema.name="mister/toolchain" \
	org.label-schema.description="ARMv7 C/C++ Toolchain for MiSTer FPGA" \
	org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.vcs-ref=$VCS_REF \
	org.label-schema.version=$BUILD_VERSION \
	org.label-schema.docker.cmd="docker run -it --rm -v ${pwd}:/mister alanswx/toolchain"

CMD ["/bin/bash"]

#RUN cd /usr/local/src/ &&  wget "https://github.com/ccxvii/mujs/archive/refs/tags/1.2.0.tar.gz" && \
#	tar zxf 1.2.0.tar.gz && ls && cd mujs-1.2.0 && make && make install

RUN cd /usr/local/src/ &&  wget "https://github.com/silnrsi/graphite/archive/refs/tags/1.3.14.tar.gz" && \
	tar zxf 1.3.14.tar.gz && ls && cd graphite-1.3.14 && mkdir build && cd build && cmake ../ -DBUILD_SHARED_LIBS:bool=off && \
	make && make install

RUN cd /usr/local/src/ &&  wget "https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.2.0.tar.gz" &&  \
	tar zxf v2.2.0.tar.gz && ls && cd openjpeg-2.2.0/ && mkdir build && cd build && \
	cmake ../ -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS:bool=off && \
	make && make install

RUN cd /usr/local/src/ &&  wget "https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz" &&  \
	tar zxf ncurses-6.2.tar.gz  && ls && cd ncurses* && ./configure --libdir=/usr/lib/arm-linux-gnueabihf --enable-widec --with-shared  &&  \
	make && make install


#
# remove dynamic libraries so we can use static ones
#
RUN rm /usr/lib/arm-linux-gnueabihf/libharfbuzz.so* 
RUN rm /usr/lib/arm-linux-gnueabihf/libopenjp2.so* 
RUN rm /usr/local/lib/libopenjp2.so*
RUN rm /usr/lib/arm-linux-gnueabihf/libjpeg.so 
RUN cp /usr/local/lib/libgraphite2.a /usr/lib/arm-linux-gnueabihf/
RUN rm /usr/lib/arm-linux-gnueabihf/libgraphite2.so*



#
# grab a copy of the pdf viewer, patch it, build it
#
RUN cd /usr/local/src/ && git clone  --recurse-submodules  "https://github.com/jichu4n/jfbview.git" && \
	 ls && cd jfbview  
ADD jfbview.patch /usr/local/src/jfbview.patch
RUN cd /usr/local/src/jfbview && patch < /usr/local/src/jfbview.patch -p1 
RUN cd /usr/local/src/jfbview && mkdir build && cd build && cmake .. -DCMAKE_CXX_STANDARD_LIBRARIES="-lgraphite2" && make



#RUN cd /usr/local/src/ &&  wget "https://github.com/mm2/Little-CMS/archive/refs/tags/lcms2.8.tar.gz" &&  \
#	tar zxf lcms2.8.tar.gz  && ls && cd Little-CMS-lcms2.8 && ./autogen.sh &&  \
#	make && make install

#RUN apt-get update && apt-get install -y \
#	libfontconfig-dev uuid-dev libboost-all-dev



#RUN cd /usr/local/src/ && wget "https://gitlab.freedesktop.org/poppler/poppler/-/archive/poppler-21.12.0/poppler-poppler-21.12.0.tar.gz" && \
#	tar zxf poppler-poppler-21.12.0.tar.gz  && cd poppler-poppler-21.12.0 && mkdir build && cd build && \
#  	cmake .. -DENABLE_QT4=OFF -DENABLE_QT4=OFF -DWITH_NSS3=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_SHARED_LIBS=OFF  && \
#	make && make install

#node-gyp ninja-build python




#RUN cd /usr/local/src/ && wget "https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_66_RTM/src/nss-3.66-with-nspr-4.30.tar.gz" && \
#	tar zxf nss-3.66-with-nspr-4.30.tar.gz  && ls && cd nss-3.66 
#	nss/build.sh --static




#RUN cd /usr/local/src/ &&  wget --no-check-certificate "https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/2.11.0/fontconfig-2.11.0.tar.gz" &&  \
#	tar zxf fontconfig-2.11.0.tar.gz  && ls && cd fontconfig-2.11.0  && ./autogen.sh &&  \
#	make && make install

#RUN cd /usr/local/src/ && wget "https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_26_RTM/src/nss-3.26-with-nspr-4.12.tar.gz" && \
#	tar zxf nss-3.26-with-nspr-4.12.tar.gz && ls && cd  nss-3.26 && \
#        cd nspr && ./configure --prefix /usr/ &&  make && make install && \
#	cd ../nss && \
#	echo "CFLAGS+=-I/usr/include/nspr/" > coreconf/Linux.mk.1 &&  \
#	cp coreconf/Linux.mk coreconf/Linux.mk.2 && cat coreconf/Linux.mk.1 coreconf/Linux.mk.2 > coreconf/Linux.mk && \
#        make nss_build_all  && \
#        make nss_build_all  && \
#        make nss_build_all  ; exit 0
#
#RUN cd /usr/local/src/nss-3.26/nss/ && make nss_build_all ; exit 0
#RUN cd /usr/local/src/nss-3.26/nss/ && make nss_build_all ; exit 0
#RUN cd /usr/local/src/nss-3.26/nss/ && make nss_build_all ; exit 0
#RUN cd /usr/local/src/nss-3.26/nss/ && make nss_build_all ; exit 0
#RUN cd /usr/local/src/nss-3.26/nss/ && make nss_build_all ; exit 0

#
# AJS CUT BELOW
#

#	tar zxf nss-3.26-with-nspr-4.12.tar.gz && ls && cd  nss-3.26 && cd nspr && ./configure --prefix /usr/ &&  make && make install && \
#        cd nss && make nss_build_all && make install 

#        d nss && echo "CFLAGS+=-I/usr/local/include/nspr/" >> coreconf/Linux.mk && 
#        make && make install && ldconfig && make install



# need to build and install nspr first, then need to add include to the Linux.mk file /usr/local/include/nspr
# https://github.com/mm2/Little-CMS/archive/refs/tags/lcms2.8.tar.gz
# https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/2.11.0/fontconfig-2.11.0.tar.gz

# gyp ninja-build
# /usr/include/nspr usr/local/include/nspr
# ./build.sh --static --system-nspr
