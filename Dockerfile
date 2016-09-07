#set the base image
FROM nginx
#file author
MAINTAINER virgil
ADD ./ /usr/share/nginx/html

