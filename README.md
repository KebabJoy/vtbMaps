# VtbMaps

### Tech stack:

* Ruby 3.1.3, Rails 7

* PostGIS

* [Docker](Dockerfile)

* [docker-compose.yml](docker-compose.yml)

* [Swagger](swagger/v1/swagger.yaml)

* CQRS/DDD manufactured

* Tests using RSwag

--- 

### How to run:
* Run `docker-compose up`
* Enter rails' container `docker exec -it vtbmaps_web_1 bash`
* Create DB -> `rails db:create`
* Run migrations -> `rails db:migrate`
* Setup DB data using seeds -> `rails db:seed`
* Now you're ready to go. Check out swagger for endpoints and input/output schemas
---
### Features
* [Bank Offices' Query](app/queries/departments_context/get_bank_offices.rb) selects the less loaded office and the closest point using postGIS' ST_Distance function to calculate distance in meters.   
* [Atms' Query](app/queries/departments_context/get_atms.rb) selects the closest ATM point using postGIS' ST_Distance function to calculate distance in meters.
* [Load Value](db/migrate/20231014140115_add_load_value_to_bank_offices.rb) added load_value defining office loading percentage
* [Seeds](db/seeds.rb) Seeds to fill up DB with ATMs and offices

* Для хранения координат мы используем расширение postGIS для PostgreSQL. Координаты хранятся в поле типа geography.
  Клиент передает координаты пользователя на бекенд. Вызывается кверя с использованием функции ST_Distance(POINT1, POINT2), таким образом мы вместе с запросом выбираем расстояние от пользователя до каждого отделения вместе с информацией об отделении. При этом мы выбираем расстояние сразу деленное на радиус поиска, таким образом, мы разделим пространство поиска на отрезки и первый попавшийся отрезок с отделениями будет первым при сортировке
  Вторая сортировка упорядочивает отделения по коэффициенту загруженности, и таким образом мы получаем ближайшее не загруженное отделение
