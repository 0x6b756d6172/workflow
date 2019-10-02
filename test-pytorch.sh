docker run -it --rm \
--gpus all --shm-size 16G \
pytorch/pytorch \
python -c "import torch; print(torch.cuda.is_available())"