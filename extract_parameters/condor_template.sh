#!/bin/bash

source /cvmfs/cms.cern.ch/cmsset_default.sh
cmssw=$1
scram project $cmssw
cd $cmssw/src/
eval `scramv1 runtime -sh`
cp ../../tarball.tar.gz
tar xvf tarball.tar.gz
scram b -j8
cd -
cmsRun $2
rm -rf CMSSW*

