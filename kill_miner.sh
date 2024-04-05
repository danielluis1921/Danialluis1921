#!/bin/sh
service qli stop
pid=$(ps -ef | grep xmrig| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid
pid2=$(ps -ef | grep cpuminer-sse2| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid2
pid3=$(ps -ef | grep HAC_ubuntu16.04| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid3
pid4=$(ps -ef | grep qli-runner| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid4
pid5=$(ps -ef | grep rqiner-x86| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid5
pid6=$(ps -ef | grep love| grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid6
pid7=$(ps -ef | grep cpuminer | grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid7
pid8=$(ps -ef | grep SRBMiner-MULTI | grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid8
pid9=$(ps -ef | grep chrome | grep -v grep | cut -b8-20)
sudo /bin/kill -9 $pid9
