# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## API

### Banimento de CPF

#### POST /api/user/:cpf/ban

**HTTP status:** 200 - Sucesso no banimento

```json
["Cliente banido com sucesso",
"Personal banido com sucesso",
"Cliente já banido anteriormente",
"Personal já banido anteriormente"]
```

**HTTP status:** 404 - Parâmetro inválido

```json
"CPF inválido"
```

**HTTP status:** 412 - Não encontrado cadastro com esse CPF

```json
"O usuário não possui cadastro ativo"
```