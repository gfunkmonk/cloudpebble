FROM gfunkmonk/python2:disco AS squashme
SHELL ["/bin/bash", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  printf 'deb https://dl.yarnpkg.com/debian/ stable main' | \
  tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y --no-install-recommends \
  gettext memcached postgresql-client libpq-dev curl git wget bash \ 
  xz-utils nodejs yarn && rm -rf /var/lib/apt/lists/* && \
  curl -L https://unpkg.com/@pnpm/self-installer | node

EXPOSE 8000

ADD requirements.txt /tmp/requirements.txt
RUN pip install psycopg2 django==1.6.2 && pip install --no-cache-dir -r /tmp/requirements.txt

# Grab the toolchain
#RUN mkdir /arm-cs-tools && \
#  curl -L "http://pebble.gfunkmonk.info/secret/arm-cs-tools/LINARO/arm-cs-tools-7.4-2019.02.tar.xz" | tar --strip-components=1 -xJ -C /

# Grab the toolchain
RUN curl -o /tmp/arm-cs-tools.tar https://cloudpebble-vagrant.s3.amazonaws.com/arm-cs-tools-stripped.tar && \
  tar -xf /tmp/arm-cs-tools.tar -C / && rm /tmp/arm-cs-tools.tar

# Install SDK 2
RUN mkdir /sdk2 && \ 
  curl -L "https://binaries.rebble.io/sdk-core/release/sdk-core-2.9.tar.bz2" | \
  tar --strip-components=1 -xj -C /sdk2

# Install SDK 3
RUN mkdir /sdk3 && \
  curl -L "https://binaries.rebble.io/sdk-core/release/sdk-core-4.3.tar.bz2" | \
  tar --strip-components=1 -xj -C /sdk3

# Install SDK 3 Node dependencies
RUN cd /sdk3 && pnpm install
ENV WAF_NODE_PATH=/sdk3/node_modules

RUN pnpm install

COPY . /code
WORKDIR /code

#RUN npm install -g bower && echo '{"allow_root": true}' > /root/.bowerrc

# Bower is awful.
#RUN rm -rf bower_components && cd /tmp && python /code/manage.py bower install && mv bower_components /code/
#RUN rm -rf node_modules && cd /tmp && python /code/manage.py bower install && mv bower_components /code/

RUN python manage.py compilemessages
RUN make -C /code/c-preload

RUN apt-get remove --purge wget xz-utils \
  autoconf automake libcurl4-openssl-dev \
  libkrb5-dev liblzma-dev libmagickcore-dev \
  libmagickwand-dev bzr mercurial subversion -y \
  && apt-get autoremove --purge -y

FROM scratch
COPY --from=squashme / /
ENV WAF_NODE_PATH=/sdk3/node_modules
WORKDIR /code

RUN python manage.py collectstatic --noinput
CMD ["sh", "docker_start.sh"]
