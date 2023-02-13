#!/bin/bash

#Author : Raoul
#Date : 02/04/2023
#Description : Install jenkins in centos7 servers

#Install OpenJDK package
 sudo yum install java-11-openjdk-devel -y 
 if 
    [ $? -ne 0 ]
    then
    echo "the installation failed, please try again"
    exit 1
 fi 
#Enable the jenkins repository

 sudo curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
 if 
    [ $? -ne 0 ]
    then 
        sudo yum install curl -y  
        if 
         [ $? -ne 0 ]
         then 
           echo "the installation failed"
           exit 2
        fi  
 fi  

#Disable key check on the repo
 sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
 if 
    [ $? -ne 0 ]
    then 
    echo "installation failed"
    exit 3
 fi    

#Install the lastest stable version of jenkins
 sudo yum install jenkins -y 
 if 
    [ $? -ne 0 ]
    then 
    echo "installation failed"
    exit 4 
 fi 

#Start the jenkins service
 sudo systemctl start jenkins 
 if 
    [ $? -ne 0 ]
    then 
    echo "the installation failed"
    exit 5
 fi

#Enable jenkins service
 sudo systemctl enable jenkins
 if 
    [ $? -ne 0 ]
    then 
    echo "the installation failed"
    exit 6
 fi 

#Verify the status of Jenkins
 sudo systemctl status jenkins 
 if 
    [ $? -ne 0 ]
    then 
    echo " installation failed"
    exit 7
 fi 

#Start the firewalld service 
 sudo systemctl start firewalld
 if
    [ $? -ne 0]
    then 
    echo "service failed"
    exit
 fi 
    
#Configure the firewall and allow 8080 port    
 sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
 if 
    [ $? -ne 0 ]
    then 
    echo "opning of port failed" 
    exit 8
 fi 

 sudo firewall-cmd --reload
 if 
    [ $? -ne 0 ]
    then 
    echo "reload failed"
    exit 9
 fi 



