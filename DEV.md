# This is a Private Mirror of emqttd
Create the mirror (It's already been done, so you can ignore it)

~~~
git clone --bare https://github.com/emqtt/emqttd.git
cd emqttd.git/
git push --mirror https://github.com/andywei/emqttd.git
cd ..
rm -rf emqttd.git
~~~

# Clone the private repo so you can work on it as a normal repo:

~~~
git clone ssh://git@github.com/andywei/emqttd.git
cd emqttd
make some changes
git commit
git push origin master
~~~

# To pull new changes from the public repo:

~~~
cd private-repo
git remote add public https://github.com/emqtt/emqttd.git
# Creates a merge commit
git pull public master 
git push origin master
~~~
