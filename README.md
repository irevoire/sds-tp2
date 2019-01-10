### Romain Grossemy
### Thomas Campistron

[rapport](RAPPORT.md)

# Requirements

We used ruby so you'll need ruby installed (`apt install ruby`, `pacman -Syyuu ruby`, ...).
You need to install the gem `Cap2`.

```bash
gem install cap2
```

# Running the web server

## Requirements

You'll need roda and rack ;

```bash
gem install roda rack
```

## Running the server

```bash
sudo rackup -p {PORT} --host 0.0.0.0
```

You can access the web server on `localhost:{PORT}`.
On `localhost:{PORT}/cap` you can get the current capabilities.

# Running a tcp server

```
sudo ruby tcp.rb
```

The tcp server will be accessible on the port 80.
