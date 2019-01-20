export yelp_input_file=$1

docker build --pull -t spark-client .

docker-compose down
docker-compose -f docker-compose.yaml up -d
sleep 10
docker exec -it spark-client /tmp/app.sh
docker-compose down


