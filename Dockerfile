FROM ruby:2.6.5
USER root
RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get install -y sudo curl apt-transport-https libcurl4 --no-install-recommends
RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" >> /etc/apt/sources.list
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN sudo apt-get update && sudo apt-get install -y \
            imagemagick \
            libmagic-dev \
            libgit2-dev \
            libmaxminddb-dev \
            pngquant \
            postgresql-server-dev-12 \
            postgresql-client-12 \
            libtiff5 libtiffxx5 \
            ffmpeg libpng-dev librsvg2-dev libjpeg-dev libwebp-dev \
            libgif-dev libtiff-dev libexif-dev \
            libvips-dev \
            nodejs \
            yarn
            
RUN apt-get install -y google-chrome-unstable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/*.deb

RUN groupadd --system chrome && \
    useradd --system --create-home --gid chrome --groups audio,video chrome && \
    mkdir --parents /home/chrome/reports && \
    chown --recursive chrome:chrome /home/chrome
    
ADD . /app
