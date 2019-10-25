#!/bin/bash
source .env
cp .env cloudpebble/.env
#rm -fdr cloudpebble/node_modules/
# Run the general build.
docker-compose build --compress --pull --force-rm --squash
#docker-compose build --pull
# Do this in the mounted directory, since the Dockerfile did it in a folder we
# mask by mounting over it.
#docker-compose run web sh -c "rm -rf bower_components && cd /tmp && python /code/manage.py bower install && cp -R bower_components/ /code/ && rm -fr /tmp/bower_components/"
docker-compose run web sh -c "python manage.py makemigrations"
docker-compose run web sh -c "mkdir -p /code/node_modules && python manage.py collectstatic --noinput"
# Stop everything again.
docker-compose stop
