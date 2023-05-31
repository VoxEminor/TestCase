FROM ruby:3.1.2
RUN apt-get update && apt-get install -y no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      postgresql-dev \
      python \
      tzdata \
     
RUN gem install bundler -v 2.0.2
WORKDIR /TestCase
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . ./
RUN psql -h localhost 

ENTRYPOINT ["./entrypoints/docker-entrypoints.sh"]



