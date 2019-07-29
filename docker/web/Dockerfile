FROM ruby:2.6.3-alpine

# Install standard library for compiling native extension
#
# - less: fix pager in pry caused by alpine
# - linux-headers: unicorn
# - postgresql-dev: pg
# - nodejs: coffee-script & uglifier
# - chromium, chromium-chromedriver: capybara-selenium
# - qpdf, ttf-liberation: pdf generation
#
RUN apk add --update --no-cache \
    build-base \
    git \
    tzdata \
    less \
    linux-headers \
    postgresql-dev \
    nodejs \
    chromium \
    chromium-chromedriver \
    qpdf \
    ttf-liberation

# Use Tokyo Timezone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Configure the main working directory. This is the base directory used in any
# further RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p /web
WORKDIR /web

COPY . /
COPY /docker/web/ /docker/

ENTRYPOINT ["sh", "/docker/entrypoint.sh"]
CMD ["sh", "/docker/command.sh"]
