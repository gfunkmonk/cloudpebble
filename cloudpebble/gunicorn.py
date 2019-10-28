worker_class = 'gevent'
workers = 6


def post_fork(server, worker):
    from psycogreen.gevent import patch_psycopg
    patch_psycopg()
