# using this kubernetes install make sure ubuntu server is there
# First check kubernetes is installed or not

kubectl 

if [ $? -eq 0 ]
then
  echo "kubernetes is already installed"
else

apt-get update -y
apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


apt install docker.io -y
usermod -aG docker ubuntu
systemctl restart docker
systemctl enable docker.service


apt-get install -y kubelet kubeadm kubectl kubernetes-cni


systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service

mkdir -p $HOME/.kube

fi