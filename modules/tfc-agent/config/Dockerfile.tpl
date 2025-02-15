FROM hashicorp/tfc-agent:${image_version}

# Install AWS CLI
USER root
RUN  apt-get update &&  apt-get install -y --no-install-recommends python3 \
    && pip3 install --upgrade pip \
    && pip3 --no-cache-dir install awscli
USER tfc-agent

# Create the hooks directory and change the owner
RUN mkdir -p /home/tfc-agent/.tfc-agent
ADD --chown=tfc-agent:tfc-agent hooks /home/tfc-agent/.tfc-agent/hooks
USER root

# Create a directory we will later save our identity token to
RUN pwd
RUN mkdir /.aws-workload
RUN chown -R tfc-agent:tfc-agent /.aws-workload
USER tfc-agent
