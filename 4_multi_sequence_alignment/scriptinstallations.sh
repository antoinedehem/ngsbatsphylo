#Ce script comprend les lignes de code ayant été utilisées pour installer les logiciel prank, trimal et phyml sur la machine virtuelle
###Prank
cd /ifb/data/mydatalocal/softwares
wget http://wasabiapp.org/download/prank/prank.linux64.170427.tgz
tar xzf prank.linux64.170427.tgz

export PATH=$PATH:/ifb/data/mydatalocal/softwares/prank/bin/prank

###PhyML
git clone https://github.com/stephaneguindon/phyml.git


cd phyml

./autogen.sh
./configure --enable-phyml
make

###trimal
export PATH=$PATH:/ifb/data/mydatalocal/softwares/phyml/src/
cd ..
git clone https://github.com/scapella/trimal.git

cd trimal/source

make

export PATH=$PATH:/ifb/data/mydatalocal/softwares/trimal/source/