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

* O campo CPF deve conter apenas números.

**HTTP status:** 200 - Sucesso no banimento do Personal

```json
{"messages":["Personal banido com sucesso"],
  "status":200
}
```

**HTTP status:** 200 - Sucesso no banimento do Cliente

```json
{"messages":["Cliente banido com sucesso"],
  "status":200
}
```

**HTTP status:** 200 - Sucesso no banimento do Personal que também é Cliente

```json
{"messages":[
    "Cliente banido com sucesso",
    "Personal banido com sucesso"
  ],
  "status":200
}
```

**HTTP status:** 404 - Parâmetro inválido

```json
{"messages":["CPF inválido"],
 "status":412
}
```

**HTTP status:** 412 - Não encontrado cadastro com esse CPF

```json
{"messages":["O usuário não possui cadastro ativo"],
 "status":404
}
```