FROM ubuntu:20.04

RUN apt update && \
    apt install -y curl python3-pip python3-venv openjdk-8-jdk-headless && \
    apt clean

ARG jupyter_version=1.0.0
RUN pip3 install jupyter==${jupyter_version}

RUN curl -Lo coursier https://git.io/coursier-cli && \
    chmod +x coursier && \
    useradd -d /jupyter jupyter && \
    mkdir /jupyter /notebooks && \
    chown jupyter -R /jupyter /notebooks

USER jupyter

ARG almond_version=0.10.9
ARG scala_version=2.12.9
RUN ./coursier launch --fork almond:${almond_version} --scala ${scala_version} -- --install

# ARG ammonite_spark_version=2.12:0.10.9
# ARG spark_version=2.12:3.0.0
RUN ./coursier fetch --default=true --sources \
    org.apache.spark:spark-sql_2.12:3.0.0 \
    org.apache.spark:spark-streaming_2.12:3.0.0 \
    sh.almond:almond-spark_2.12:0.10.9

# to better use cache
RUN ./coursier fetch --default=true --sources \
    commons-codec:commons-codec:1.9 \
    sh.almond:spark-stubs_30_2.12:0.10.1

RUN pip3 install  pyspark==3.1.2

EXPOSE 8888

CMD [ "jupyter-notebook", "--NotebookApp.ip=0.0.0.0", "--notebook-dir=/notebooks", "--NotebookApp.token=''" ]