# .

Welcome to your new Hanami project!

## Setup

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

Explore Hanami [guides](http://hanamirb.org/guides/), [API docs](http://docs.hanamirb.org/1.2.0/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸

# Docker para ambiente de dev
`docker build -f Dockerfile.dev .` para construir 
`docker-compose up` para habilitar
`docker-compose down` stop e remove

# Docker para ambiente de prod
`docker build -t ayga-api -f Dockerfile .` para construir
`docker run -d -it -p 2300:2300 --name=api ayga-api bundle exec puma -C 'config/puma.rb'` para rodar
`docker stop ayga-api` para stop
`docker rm ayga-api` para remover container

# Instalação (caso não use docker)
`bundle install`

# To-do
## BACKEND
| | API com autenteticação dos endpoints por TOKEN
| | Disponibilizar a listagem de todos os vídeos
| | Busca por palavras ou tags

| | Interface web
| | CRUD :: Titulo, descrição curtam, imagem de pré visualização, URL do youtube

| | Adicionar Docker
| | Hasura
| | Cobertura de código - simplecov
| | CodeClimate
| | SemaphoreCI
| | Overcommit 

Adicionado Puma server para produção
Habilitado http2/early hits
