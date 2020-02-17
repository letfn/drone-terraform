FROM letfn/container AS download

ARG _TERRAFORM_VERSION=0.12.20

WORKDIR /tmp

RUN curl -sSL -O https://releases.hashicorp.com/terraform/${_TERRAFORM_VERSION}/terraform_${_TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${_TERRAFORM_VERSION}_linux_amd64.zip \
  && chmod 755 terraform

FROM letfn/container

COPY --from=download /tmp/terraform /usr/local/bin/terraform

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
