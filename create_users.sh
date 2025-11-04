USER_NAME=$1;
PORT_NUMBER=$2;

docker volume create ${USER_NAME}_UL;
docker run -it -d --privileged --name=${USER_NAME}_UL_Desktop -v ${USER_NAME}_UL:/home/rocket -p ${PORT_NUMBER}:3389 eda-ubuntu-desktop:2

#use below command to create an image
#docker build -t ubuntu-desktop .
