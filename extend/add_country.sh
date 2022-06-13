source .env 

psql --host=${HOST:-localhost} --port=${PORT:-5432} -U ${USER:-user} -d ${DB:-osm} -f sql/drop_unnecessary_tables.sql &&\
    osm2pgsql -H ${HOST:-localhost} -P ${PORT:-5432} -U ${USER:-user} -d ${DB:-osm} -r pbf <(wget -q -O - $1) &&\
    psql --host=${HOST:-localhost} --port=${PORT:-5432} -U ${USER:-user} -d ${DB:-osm} -f sql/categorized_insert.sql
