# README

## API 

### Consulta de Clientes

#### GET /api/v1/clients

**HTTP status:** 200

```json 
[
    {
       "id":1,
       "email": "teste@teste.com",
       "cpf": "34021467033",
    },
    {
       "id":2,
       "email": "fulano@teste.com",
       "cpf": "34021467033",
    }
]
```

### Consulta de Cliente único

#### GET /api/v1/client/:id

**HTTP status:** 200

```json 
[
    {
       "id":1,
       "email": "teste@teste.com",
       "cpf": "34021467033",
    }
]
```

**HTTP status:** 404 - Parâmetro inválido

```json
"Cliente não encontrado"
```

### Banimento de CPF

#### POST /api/user/:cpf/ban

* O campo CPF deve conter apenas números.

**HTTP status:** 200 - Sucesso no banimento do Personal

```json
{   
    "messages":["Personal banido com sucesso"],
    "status":200
}
```

**HTTP status:** 200 - Sucesso no banimento do Cliente

```json
{
    "messages":["Cliente banido com sucesso"],
    "status":200
}
```

**HTTP status:** 200 - Sucesso no banimento do Personal que também é Cliente

```json
{ 
    "messages":
        [
            "Cliente banido com sucesso",
            "Personal banido com sucesso"
        ],
    "status":200
}
```

**HTTP status:** 404 - Parâmetro inválido

```json
{   
    "messages":["CPF inválido"],
    "status":412
}
```

**HTTP status:** 412 - Não encontrado cadastro com esse CPF

```json
{
    "messages":["O usuário não possui cadastro ativo"],
    "status":404
}
```
