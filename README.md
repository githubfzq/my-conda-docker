# my-conda-docker
An anaconda docker as data analysis environment

## Install
下载本项目

Matlab 2017b linux安装包下载链接：https://pan.baidu.com/s/1wijZCXIWsNXgz0yYYBXHnQ 密码：e8b2.

下载安装包于本项目文件夹并解压.iso文件以及crack压缩包。

## Use

例如，
```angular2
docker run -it -p 9102:8888 --name my_conda --mount type=bind,source="E:\docker project\my-conda-docker",target=/home/docker_files --mount type=bind,source="E:\data",target=/home/data --privileged fantasy0801/conda:matlab_kernel
```


