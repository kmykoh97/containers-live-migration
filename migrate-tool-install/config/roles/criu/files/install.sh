sudo apt update
sudo apt install -y build-essential
sudo apt install -y pkg-config
sudo apt install -y libnet-dev python-yaml libaio-dev
sudo apt install -y libprotobuf-dev libprotobuf-c0-dev protobuf-c-compiler protobuf-compiler python-protobuf libnl-3-dev libcap-dev python-future

# criu install
cd
curl -O -sSL http://download.openvz.org/criu/criu-3.13.tar.bz2
tar xjf criu-3.13.tar.bz2 
cd criu-3.13
make
sudo cp ./criu/criu /usr/local/bin