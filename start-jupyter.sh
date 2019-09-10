./build.sh

docker run -d \
    --name jupyter \
    -u 1000:1000 \
    -p 8888:8888 \
    -p 6006:6006 \
    --restart always \
    --gpus all --shm-size 16G \
    -v /home/user/Workspace:/workspace \
    fastai \
    jupyter lab --ip=0.0.0.0

sleep 5

docker exec -it jupyter /bin/bash -c "jupyter notebook list"
docker exec -it jupyter /bin/bash