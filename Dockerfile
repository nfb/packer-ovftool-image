FROM ubuntu:latest
RUN apt update
RUN apt install -y wget unzip
RUN wget https://github.com/rgl/ovftool-binaries/raw/main/archive/VMware-ovftool-4.4.3-18663434-lin.x86_64.zip
RUN unzip VMware-ovftool-4.4.3-18663434-lin.x86_64.zip
RUN wget https://releases.hashicorp.com/packer/1.11.2/packer_1.11.2_linux_amd64.zip
RUN unzip packer_1.11.2_linux_amd64.zip
RUN rm VMware-ovftool-4.4.3-18663434-lin.x86_64.zip packer_1.11.2_linux_amd64.zip
RUN rm -rf /var/cache/apt/archives /var/lib/apt/lists/*. 
RUN apt remove -y wget unzip
RUN apt autoclean -y

FROM ubuntu:latest
RUN mkdir /packer /ovftool
COPY --from=0 packer /packer/
COPY --from=0 /ovftool /ovftool
ENV PATH="$PATH:/ovftool"
ENV PATH="$PATH:/packer/"

