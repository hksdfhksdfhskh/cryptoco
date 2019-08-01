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

## Using docker-sync

I use docker-sync so that my changes will be synchronized to the container's painlessly.

### Implementing timeout on HTTP calls to CoinMarketCap

It is a good practice to setup a timeout. So that in the case of having a slow connection, it wouldn't affect our system's performance.

## Service classes

I like having service class that adhere to Single Responsibility Principle. The service class will always have the following method:

- `process`: to do certain task the service is focused at doing

A service might not execute successfully, in that case, we can retrieve the errors through `errors` function (but, not all service need to implement this).

## API modules

The `app/apis` folders contain 3rd party APIs implementations. The implementation is business-less and stateless. They are all pure API calls wrapped in a neat, readable function.