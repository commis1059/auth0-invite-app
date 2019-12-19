# README

This project is a sample of Invite-Only Applications in Auth0.

## Structure

* Frontend: Vue Cli
* Backend: Nginx on Docker + Ruby on Rails
* Job worker: Redis on Docker + Sidekiq
* Database: MySQL on Docker

## Configuration
### .env
You need to configure .env.

* APP_HOST: Railsを稼働させるホストのIPアドレス
* APP_PORT: Railsを稼働させるホストのポート番号
* AUTH_ISS: 当該タレントのドメイン名
* AUTH_AUD: 当該APIの識別子
* AUTH0_DOMAIN: 当該タレントのドメイン名
* AUTH0_CLIENT_ID: Auth0 API Explorer ApplicationのClient ID
* AUTH0_CLIENT_SECRET: Auth0 API Explorer ApplicationのClient Secret
* AUTH0_DB_CONNECTION_ID: インポート対象のデータベースのコネクションID（To get the ID, you need to use the following API: https://auth0.com/docs/api/management/v2#!/Connections/get_connections）
* DB_ROOT_PASSWORD: データベースのrootのパスワード
* DB_HOST: データベースのホストのIPアドレス
* DB_PORT: データベースのホストのポート番号
* REDIS_PORT: Redisのポート番号
* WEB_PORT: Nginxのポート番号
* VUE_APP_PROXY_PORT: ${WEB_PORT}(Unable to edit)

### frontend/auth_config.json
You need to configure frontend/auth_config.json.

```
{
  "domain": Your domain,
  "clientId": Your application client ID,
  "audience": Your API Identifier
}
```

## Usage
### Start-up
```
docker-compose up
bundle exec ruby bin/rails s
cd frontend; yarn serve; cd ..
bundle exec sidekiq
```
### User import
1. Access to http://localhost:8080/ by browser.
1. Login.
1. Click "External Api".
1. Select json file.
1. Click "Send".

## References

* https://auth0.com/docs/design/creating-invite-only-applications
* https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports
* https://auth0.com/docs/quickstart/spa/vuejs
* https://auth0.com/docs/quickstart/backend/rails
* https://github.com/guillaumebriday/rails-vue-cli
* https://github.com/auth0/ruby-auth0
