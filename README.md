# cacti
USAGE

Create directory for persistent data: accounts, emails, databases and logs.
```
mkdir -p /data/ 
```



Start docker.
```
docker run -d -v /data/mysql:/var/lib/mysql -v /data/log -v /data/cacti:/var/lib/cacti/rra -p 80:80 idle/cacti
```



After running container, you can access cacti here - http://yourhost/cacti, login/password = admin/admin(after first login it will be forced to change password).

