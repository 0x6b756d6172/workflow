docker run -it --rm \
---gpus all --shm-size 16G \
tensorflow/tensorflow:latest-gpu \
python -c "import tensorflow as tf; print(tf.test.is_gpu_available())"