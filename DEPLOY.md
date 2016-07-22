# Config MQTT Server
~~~
sudo vim /etc/hosts
~~~
then add the below line:

~~~
192.168.215.42 kfk0.xoxoio.com kfk0
~~~

# Install Erlang/OTP 18

https://www.erlang-solutions.com/resources/download.html

~~~
sudo yum install epel-release
sudo yum -y update && sudo yum -y upgrade

wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
sudo yum install esl-erlang
~~~

# Install Git
~~~
sudo yum install git
~~~

# Install, config and run emqttd
~~~
cd ~
git clone https://github.com/andywei/emqttd.git
cd emqttd
git checkout -b onlyu origin/onlyu
vim rel/files/vm.args #for node name 
make && make dist
sudo rel/emqttd/bin/emqttd start
sudo rel/emqttd/bin/emqttd_ctl plugins load emqttd_plugin_observer
sudo rel/emqttd/bin/emqttd_ctl plugins load emqttd_plugin_jwt
~~~
Note the last 4 lines must be run mannually, if run install.sh the emqttd can not be started 

