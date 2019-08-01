# Cryptoco

```
$ gem install docker-sync
$ docker-sync start
$ docker-compose build
$ docker-compose up
$ docker-compose run web rails c
$ docker-compose run web bundle exec rake setup:all
```

## Decisions

### Using docker-sync

I use docker-sync so that my changes will be synchronized to the container's painlessly.

### Implementing timeout on HTTP calls to CoinMarketCap

It is a good practice to setup a timeout. So that in the case of having a slow connection, it wouldn't affect our system's performance.

### Service classes

I like having service class that adhere to Single Responsibility Principle. The service class will always have the following method:

- `process`: to do certain task the service is focused at doing

A service might not execute successfully, in that case, we can retrieve the errors through `errors` function (but, not all service need to implement this).

### API modules

The `app/apis` folders contain 3rd party APIs implementations. The implementation is business-less and stateless. They are all pure API calls wrapped in a neat, readable function.

### Rails Credentials

I am using Rails [encrypted credentials](https://www.engineyard.com/blog/rails-encrypted-credentials-on-rails-5.2) to store sensitive data. This way, we can safely commit the sensitive data into the repository. To open the credentials, we will need a master key. We need to keep this key very carefully, but since this is a take-home test app, I will kindly share the master key here :) ~please take care~ ;')

```
dd82364f58bc37e0d61359c4aa00e5da
```

### Rake tasks

Rake task is a handy tools to run arbitrary scripts related to the system. For example, a rake task is made for downloading the latest market value. Later, this rake task can be executed by a cron job/scheduler at a certain interval.

### Slim templates

Slim is a templating engine that is very minimalist, and also compile fast compared to other engines (such as HAML).

### Bootstrap

Bootstrap makes it easy to build a responsive website. Its syntax is relatively intuitive to use. It also has a lot of additional components, such as: card, navbar, etc. It has a modern and clean look and feel. A well-written documentations do help, too.

### Newline-ender

Every files should end in an empty newline. This is to avoid unnecessarily changing history of a code that happen to be at the tail of the file.
