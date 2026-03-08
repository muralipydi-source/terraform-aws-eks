######################################################################
# #!/bin/bash

# yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
# yum -y install terraform

# growpart /dev/nvme0n1 4
# lvextend -L +20G /dev/RootVG/rootVol
# lvextend -L +10G /dev/RootVG/homeVol

# xfs_growfs /
# xfs_growfs /home

# dnf -y install dnf-plugins-core
# dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
# dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# systemctl start docker
# systemctl enable docker
# usermod -aG docker ec2-user

# ARCH=amd64
# PLATFORM=$(uname -s)_$ARCH
# curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
# tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
# install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

# curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/amd64/kubectl
# chmod +x ./kubectl
# mv kubectl /usr/local/bin/kubectl

# eksctl version
# kubectl version

# git clone https://github.com/ahmetb/kubectx /opt/kubectx
# ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
# chmod 700 get_helm.sh
# ./get_helm.sh

##########################################################################################

#!/bin/bash

set -e

# Install required utilities
yum install -y yum-utils curl git tar cloud-utils-growpart

# Install Terraform
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install -y terraform

# Extend disk volumes
growpart /dev/nvme0n1 4

lvextend -L +20G /dev/RootVG/rootVol
lvextend -L +10G /dev/RootVG/homeVol

xfs_growfs /
xfs_growfs /home

# Install Docker
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

# Install eksctl
ARCH=amd64
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"
tar -xzf eksctl_${PLATFORM}.tar.gz -C /tmp
rm eksctl_${PLATFORM}.tar.gz

install -m 0755 /tmp/eksctl /usr/local/bin
rm /tmp/eksctl

# Install kubectl
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

# Verify installations
eksctl version
kubectl version --client

# Install kubectx / kubens
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# Install Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh