** Setup Enviroment **

- cp .env.example .env
- Change values in mysql of file .env
  + DB_CONNECTION=mysql
  + DB_HOST=digimart_db
  + DB_PORT=3306
  + DB_DATABASE=digimart
  + DB_USERNAME=digimart
  + DB_PASSWORD=root
- docker compose up database -d
- docker compose up -d

  ** Test local **
  http://localhost:6160
