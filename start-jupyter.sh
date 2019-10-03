./build.sh

docker run -d \
    --name jupyter \
    -u 1000:1000 \                    # host uid mapping
    -p 8888:8888 \                    # jupyter port
    -p 6006:6006 \                    # tensorboard port 
    --gpus all \                      # share gpu
    --shm-size 16G \                  # share all host memory
    -v <project-dir>:/workspace \     # point to your project dir
    fastai \                          # named image built as part of build step
    jupyter lab --ip=0.0.0.0          # run jupyter in lab mode

sleep 5                               #give the container time to startup

docker exec -it jupyter /bin/bash -c "jupyter notebook list" # show auth cookie
docker exec -it jupyter /bin/bash     # drop into bash in the container