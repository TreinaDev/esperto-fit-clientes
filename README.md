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

**HTTP status:** 404 - Parâmetro inválido

```json
Cliente não encontrado
```
