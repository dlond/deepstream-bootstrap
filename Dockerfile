# FROM nvcr.io/nvidia/deepstream:5.1-21.02-devel
FROM nvcr.io/nvidia/deepstream:6.1.1-devel

# COPY myapp  /root/apps/myapp
# To get video driver libraries at runtime (libnvidia-encode.so/libnvcuvid.so)
ENV NVIDIA_DRIVER_CAPABILITIES $NVIDIA_DRIVER_CAPABILITIES,video

RUN /opt/nvidia/deepstream/deepstream/user_additional_install.sh

RUN apt-get update && apt-get install -y python3-pip python3-numpy
RUN pip3 install torch torchvision opencv-python

# ENV GI_TYPELIB_PATH /usr/lib/x86_64-linux-gnu/girepository-1.0/

RUN python3 -c "import torch; torch.hub.load('NVIDIA/DeepLearningExamples:torchhub', 'nvidia_ssd', model_math='fp32')" 2>/dev/null | :
RUN python3 -c "import torch; torch.hub.load('NVIDIA/DeepLearningExamples:torchhub', 'nvidia_ssd', model_math='fp16')" 2>/dev/null | :

WORKDIR /opt/nvidia/deepstream/deepstream/sources/apps/my-app