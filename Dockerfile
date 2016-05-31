FROM gcr.io/tensorflow/tensorflow
MAINTAINER evanlezar@gmail.com

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends zsh


ARG user_id
ARG user_name
ARG group_id=$user_id
RUN if [ x"$(getent group $group_id)" == x"" ]; then addgroup --gid $group_id $user_name ; fi
RUN adduser --gecos "Developer" --quiet --uid $user_id --gid $group_id --disabled-password --force-badname $user_name --shell /bin/zsh

CMD /bin/zsh
