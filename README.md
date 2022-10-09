# VSpace
### Стек
```
0. Ruby on Rails
1. Postgresql
2. Monads
3. Heroku
```
### Файловая структура проекта
* Миграции базы данных [/db/migrate/](https://github.com/KebabJoy/VSpace/tree/master/db/migrate)
* JSON сериалайзеры [/app/blueprinters/](https://github.com/KebabJoy/VSpace/tree/master/app/blueprinters)
* Контроллеры, в которых описаны эндпоинты [/app/controllers/](https://github.com/KebabJoy/VSpace/tree/master/app/controllers)
* Модели, которых хранят в себе данные и бизнес логику [/app/models/](https://github.com/KebabJoy/VSpace/tree/master/app/models)
* Сервисы, в которых описана бизнес логика [/app/services/](https://github.com/KebabJoy/VSpace/tree/master/app/services)
* Классы для поиска с помощью фильтров [/app/search/](https://github.com/KebabJoy/VSpace/tree/master/app/search)

### Как запустить?
* Установить rbenv -> `rbenv install 2.7.5` -> `rbenv local 2.7.5` -> `rbenv rehash`
* Установить `postgresql`, при необходимости подключить БД тут -> `/config/database.yml`
* Запустить `bundle install`, чтобы установить все гемы
* Установить webpacker `bundle exec rails install:webpacker`
* Создать БД со всеми таблицами `bundle exec rake db:create` -> `bundle exec rake db:migrate`
* Запустить сервер `bundle exec rails s`
