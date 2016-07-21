# Config MQTT Server
~~~
sudo vim /etc/hosts
~~~
then add the below line:

~~~
192.168.215.42 kfk0.xoxoio.com kfk0
~~~

# Get the source code
~~~
cd /opt
sudo git clone https://github.com/andywei/emqttd.git
cd emqttd
sudo ./install.sh
~~~