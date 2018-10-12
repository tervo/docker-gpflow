FROM python:3.6

RUN mkdir /a
WORKDIR /a
RUN chmod 777 /a

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_CTYPE=C.UTF-8

RUN apt-get update
RUN apt-get install -y curl htop
# RUN apt-get install -y wget graphviz libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev

## Google sdk python libraries
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-jessie main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install -y google-cloud-sdk

RUN pip install --upgrade requests pandas tensorflow google-cloud google-api-python-client google-auth-httplib2 google-cloud-bigquery[pandas] pyarrow google-cloud-storage scikit-learn keras boto3

RUN mkdir /tmp/i && cd /tmp/i && git clone https://github.com/GPflow/GPflow.git . && pip install . && rm -rf /tmp/i
