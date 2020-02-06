FROM alpine:3.9

ARG TERRAFORM_VERSION
ARG TERRAFORM_VERSION_SHA256SUM


COPY terraform_${TERRAFORM_VERSION}_linux_amd64.zip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

FROM gcr.io/cloud-builders/gcloud

COPY --from=0 terraform /usr/bin/terraform
COPY entrypoint.bash /builder/entrypoint.bash
ENTRYPOINT ["/builder/entrypoint.bash"]


