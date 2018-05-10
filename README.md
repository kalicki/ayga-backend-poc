Este projeto está escrito em Ruby com uso do framework Hanami. Abaixo tem algumas informações importantes para o entendimento básico do projeto:

# Caracteristicas:
Ruby >= 2.5
Hanami = 1.2
PostgreSQL
Argon2
JWT

# Arquitetura
Hanami é baseado em uma arquitetura "Clean" e Monolith First, porém, este projeto foi segmento para escalar de modo fácil usando a técnica da "Umbrella" (escalar sem precisar de microserviços) ou "Container", ou seja, cada evento - create, delete, e outros - está isolado, em caso de necessidade de escalomento é só desacoplar o evento que tem maior demanda e separar em um serviço.

Organizações das pastas:
`apps` - Está toda manipulação de roteamento e controle, neste caso, somente a API está habilitado.
`config` - Configurações gerais da aplicação, porém, é composta de forma global para qualquer aplicação que esteja em `apps`
`db` - Contém os migratios e estruturação do DB
`lib` - É composta por toda estrturação e manipulação entre entidade (Entity) e o dados (Repository)
    `repositories` - Manipula as informações de DB e controlar
    `entities` - Informações da entidade, ou seja, é possível fazer restrição de tipagem, gets, sets e outras coisas ligado a classe.
    * Importante: O Hanami já faz alguns tratamento na entidade de forma automática, baseado na informações do DB.

Para mais informações: hanamirb.org/guides/1.2/architecture/overview/

# Endpoints
POST /sing_up
Parâmetros:
    - first_name => string
    - last_name => string
    - email => string
    - encrypted_password => string
    - encrypted_password_confirmation => string
    - admin => bool (defautl: false)
Descrição: Cria um novo usuário baseado nas informações de parâmetros.
Retorno: JSON com dados do usuário (sem a senha).

POST /sing_in
Parâmetros:
    - email => string
    - password => string
Descrição: Efetua o login.
Retorno: JSON com Token para uso em JWT

DELETE /users/:id
Parâmetros:
    - id => uuid
Descrição: Remove um usuário baseado no ID
Retorno: JSON com mensagem de sucesso ou negativo.

GET /videos
Descrição: Mostra todos os vídeos visiveis.
Retorno: JSON com vídeos e opções de paginaçõ.

GET /videos/:id
Parâmetros:
    - id => uuid
Descrição: Retorna o vídeo solitado por ID.
Retorno: JSON com informações do vídeo.

POST /videos
Parâmetros:
    - title => string
    - thumbnail => string
    - url_video => string
    - tags => Array string
    - visible => bool (default: true)
Descrição: Cria um novo vídeo baseado nos parâmetros.
Retorno: JSON com informações do vídeo criado.

PATCH /videos/:id
Parâmetros:
    - title => string
    - thumbnail => string
    - url_video => string
    - tags => Array string
    - visible => bool (default: true)
Descrição: Atualiza vídeo de um ID solicitate, baseado nos parâmetros.
Retorno: JSON com informações do vídeo atualizado.

DELETE /videos/:id
Parâmetros:
    - id => uuid
Descrição: Remove um vídeo baseado no ID solicitante.
Retorno: JSON com mensagem.

GET /videos/search
Parâmetros:
    - query => string
Descrição: Busca um vídeo baseado na query (title, description, tags)
Retorno: JSON com resultado da pesquisa.

* `/sign_up` e `/sing_in` não possui autenticação de endpoint (JWT), os demais tem que ser redirecionado o `auth_token` que é gerado e retornado no momento do login. Enviar o token no cabeçalho (header) do request baseado no padrão: `Authorization Bearer`.

# Envs
A configuração básica está baseado em `.env`, por meio de váriveis de ambientes, no caso de development e test o Hanami tem gerenciamento automático baseado na situação do `HANAMI_ENV`.
Nesses arquivos estão configurações como Banco de dados, JWT secret, Cors, e outros.
Em caso de produção, é necessário exportar, exemplo: `export CORS_ALLOW_HEADERS="Content-Type Accept Auth-Token"`, assim, as informações ficam na integridade do sistema onde será executado e não em arquivos, é importante ver as boas práticas da hoespedagem/nuvem ou do sistema onde irá rodar em produção. 

# Instalação (caso não use docker)
É necessário instalar todos os pacotes do backend, para isto execute no terminal `bundle install`

Também, é necessário fazer a criação e exeução do banco de dados, que está baseado em PostgreSQL.
Comando: `bundle exec hanami db prepare`

Para habilitar o ambiete de teste pasta setar uma varivel de ambiente `HANAMI_ENV=...`
Comando: `HANAMI_ENV=test bundle exec hanami db prepare`

Para executar o servidor do Hanami que está baseado em Puma:
Comando `bundle exec hanami server` 
Ele irá executar na porta 2300 no caminho `http://localhost:2300/api`

Existe a opção de executar com Webrick, porém, não recomendo. Use Puma, que já está pré-configurado.
Comando: `bundle exec hanami server --server=webrick`

# Docker
Use docker-compose somente em ambiente de desenvolvimento, seguindo as boas práticas de Container.

### Docker para ambiente de development
Build: `docker build -f Dockerfile.dev .`
Executar: `docker-compose up` para habilitar
Parar e remover: `docker-compose down`

### Docker para ambiente de prod
Gerar o build: `docker build -t ayga-api -f Dockerfile .`
Executar: `docker run -d -it -p 2300:2300 --name=api ayga-api bundle exec puma -C 'config/puma.rb'`
Parar o container: `docker stop ayga-api`
Remover: `docker rm ayga-api`

---
Explore Hanami [guides](http://hanamirb.org/guides/), [API docs](http://docs.hanamirb.org/1.2.0/), or jump in [chat](http://chat.hanamirb.org) for help. Enjoy! 🌸