#FROM arm32v7/debian:stretch-slim
FROM arm32v7/debian:bullseye-slim

# Environment Variable
ENV DEBIAN_FRONTEND=noninteractive
ENV MISTER_ROOT=/mister

# Switches for Optimization
#ENV CFLAGS="-mfloat-abi=hard -march=armv7-a -mfpu=neon-vfpv3 -mtune=cortex-a9"
#ENV CXXFLAGS="-mfloat-abi=hard -march=armv7-a -mfpu=neon-vfpv3 -mtune=cortex-a9"
ENV MAKEFLAGS="-j$(nproc)"

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
	#libfreetype6-dev \
	liblcms2-dev \
	libgmp3-dev \
	#libharfbuzz-dev \
	libwebp-dev \
	libzstd-dev \
	libjbig2dec0-dev \
	libjsoncpp-dev \
	liblz4-tool \
	libmpc-dev \
	libmpfr-dev \
 	libmupdf-dev \
	#libncurses5-dev \
	libpcap-dev \
	#libpng-dev \
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



WORKDIR /usr/local/src/

RUN wget "https://github.com/pnggroup/libpng/archive/refs/tags/v1.6.58.tar.gz" && tar zxf v1.6.58.tar.gz && rm v1.6.58.tar.gz
RUN cd libpng-* && ./configure --prefix=/usr/local --disable-shared --enable-static \
	CFLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	CXXFLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd libpng-* && make && make install

RUN wget "https://github.com/freetype/freetype/archive/refs/tags/VER-2-14-3.tar.gz" && tar zxf VER-2-14-3.tar.gz && rm VER-2-14-3.tar.gz
RUN cd freetype-VER-* && mkdir build && cmake -Bbuild -DBUILD_SHARED_LIBS:bool=off -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd freetype-VER-*/build && make && make install

RUN wget "https://github.com/silnrsi/graphite/archive/refs/tags/1.3.14.tar.gz" && tar zxf 1.3.14.tar.gz && rm 1.3.14.tar.gz
RUN cd graphite-* && sed -i '/add_subdirectory(tests)/d' CMakeLists.txt && mkdir build && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS:bool=off -DCMAKE_CXX_STANDARD_LIBRARIES="-lpng -lfreetype -ldl -lz" \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9  -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd graphite-*/build && make && make install

RUN wget "https://github.com/uclouvain/openjpeg/archive/refs/tags/v2.5.4.tar.gz" && tar zxf v2.5.4.tar.gz && rm v2.5.4.tar.gz
RUN cd openjpeg-*/ && mkdir build && cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS:bool=off \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9  -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd openjpeg-*/build && make && make install

RUN wget "https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/3.1.4.1.tar.gz" && tar zxf 3.1.4.1.tar.gz && rm 3.1.4.1.tar.gz
RUN cd libjpeg-* && mkdir build && \
	cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DENABLE_SHARED=off -DENABLE_STATIC=on -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DWITH_TOOLS=off -DWITH_TESTS=off -DWITH_SIMD=on -DWITH_TURBOJPEG=off -DWITH_JPEG8=off \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9  -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd libjpeg-*/build && make && make install

RUN wget "https://github.com/harfbuzz/harfbuzz/archive/refs/tags/14.2.1.tar.gz" && tar zxf 14.2.1.tar.gz && rm 14.2.1.tar.gz
RUN cd harfbuzz* && mkdir build && \
	cmake -Bbuild -DCMAKE_BUILD_TYPE=Release  -DBUILD_SHARED_LIBS=off -DHB_BUILD_SUBSET=off -DCMAKE_PREFIX_PATH=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DHB_HAVE_GRAPHITE2=on -DHB_HAVE_FREETYPE=on -DHB_HAVE_GLIB=off -DHB_HAVE_ICU=off -DHB_HAVE_CAIRO=off -DHB_HAVE_DIRECTWRITE=off \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd harfbuzz*/build && make && make install

RUN wget "https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz" && tar zxf ncurses-6.2.tar.gz && rm ncurses-6.2.tar.gz
RUN cd ncurses-* && ./configure --libdir=/usr/lib/arm-linux-gnueabihf --enable-widec --with-shared --without-manpages --without-tests --without-debug --without-ada --without-progs
RUN cd ncurses-* && make && make install


#
# remove dynamic libraries so we can use static ones
#

RUN cp /usr/local/lib/libpng*.a /usr/lib/arm-linux-gnueabihf/ && \
	cp /usr/local/lib/libgraphite2.a /usr/lib/arm-linux-gnueabihf/ && \
	cp /usr/local/lib/libharfbuzz*.a /usr/lib/arm-linux-gnueabihf/ && \
	cp /usr/local/lib/libfreetype*.a /usr/lib/arm-linux-gnueabihf/ && \
	rm /usr/lib/arm-linux-gnueabihf/libopenjp2* && cp /usr/local/lib/libopenjp2.a /usr/lib/arm-linux-gnueabihf/ && \
	rm /usr/lib/arm-linux-gnueabihf/libjpeg.* && cp /usr/local/lib/libjpeg.a /usr/lib/arm-linux-gnueabihf/



# grab a copy of the pdf viewer, build it
ARG PROJECT_REFRESH=1
RUN git clone --recursive "https://github.com/bemjo/pdfviewer.git"
ARG PDFVIEWER_REFRESH=1
RUN cd pdfviewer && git config pull.rebase true && git pull
RUN cd pdfviewer && mkdir build && cmake -H. -Bbuild \
	-DCMAKE_CXX_STANDARD_LIBRARIES="-lgraphite2 -ljpeg -lharfbuzz -lpng -lfreetype -ldl -lz" \
	-DCMAKE_C_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3" \
	-DCMAKE_CXX_FLAGS="-Ofast -ffast-math -mfloat-abi=hard -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon-vfpv3"
RUN cd pdfviewer/build && make
