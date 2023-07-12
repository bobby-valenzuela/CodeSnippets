Create an html file as so:  
```html
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Server: MEOW

<!DOCTYPE html>
<html>
        <p>Hi fellow cat!</p>
</html> 
```

<br />

Listen on netcat with:
```bash
nl -l <port> < netcat-webserver
```


