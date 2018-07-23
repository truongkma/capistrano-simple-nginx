# Capistrano::SimpleNginx
Support for Capistrano 3.x

## Installlation

Add this line to your application's `Gemfile`:
```
gem 'capistrano'
gem 'capistrano-simple-nginx', '~> 0.0.1'
```

And then run:
```
$ bundle
```
Or install it yourself as:
```
$ gem install capistrano-simple-nginx
```

## Usage

Require in `Capfile`:
```
require 'capistrano/simple-nginx'
```

* Generate file config nginx, run:
```
$ cap production nginx:setup
```

* start|stop|restart nginx, run:
```
$ cap production nginx:start
$ cap production nginx:stop
$ cap production nginx:restart
```

You need add directory to sock file of app. Example using unicorn for app:
```
# in config/deploy.rb
set :nginx_upstream_file, "/tmp/unicorn.sock"
```

## Default config

```
    set :nginx_listen_port, 80 #listen_port
    set :nginx_server_name, "_" #server_name
    set :nginx_upstream_name, -> { "#{fetch(:application)}" } # upstream name
    set :nginx_config_name, -> { "#{fetch(:application)}_#{fetch(:stage)}" } #file name config
    set :nginx_fail_timeout, 0
    set :nginx_access_log_file, -> { "/var/log/nginx/#{fetch(:nginx_config_name)}.access.log" } # access log file
    set :nginx_error_log_file, -> { "/var/log/nginx/#{fetch(:nginx_config_name)}.error.log" } # error log file
    set :nginx_upstream_file, -> { "/tmp/#{fetch(:application)}.sock" } # .sock file path
```


