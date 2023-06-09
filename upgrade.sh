#!/bin/bash


echo ".......................STARTING UPGRADE.................." 
sleep 1

echo ".........................STOPPING JENKINS SERVICE.................."

oldversion=$(sudo jenkins --version)

sudo service jenkins stop

jenkins=$(sudo grep jenkins /etc/passwd | cut -d: -f6)

jenkinswar="/usr/share/java"

echo "..................MAKING JENKINS BACKUP..................."

sudo tar -cvzf jenkins_date.tar.gz $jenkins

sudo mv -f jenkins_date.tar.gz $HOME


sudo mv $jenkinswar/jenkins.war $jenkinswar/jenkins.war.old

echo ".......................DOWNLOADING THE LATEST JENKINS VERSION..................."

sudo wget https://updates.jenkins-ci.org/latest/jenkins.war

sudo mv jenkins.war $jenkinswar/jenkins.war
sudo chown root:root $jenkinswar/jenkins.war

echo "..........RESTARTING JENKINS..............."
sudo service jenkins start 
echo "..........UPGRADE COMPLETE........."
echo "Old version is $oldversion"
echo "New version is $(sudo jenkins --version)"

echo "...... YOU CAN FIND BACKUP FILES IN $HOME and $jenkinswar folders ........."