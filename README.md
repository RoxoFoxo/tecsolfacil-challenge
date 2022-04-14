# Tecsolfacil

## Solution

First you need an account to login into API to create a JWT, which you use as your bearer token to access the addresses routes, where you can either:

  * Search for specific CEPs which sends requests to ViaCEP's API through Finch and returns their info and saves it for later searches if the CEP is valid.
  * Access the export route where it'll send you an email with a CSV of all addresses in the database as an attachment to it, the CSV generation and email being done in a background job.

## How to Run

First you build and run the docker:

  ```
  sudo docker build -t tecsolfacil:latest .
  sudo docker run --network=host tecsolfacil:latest
  ```

Then you can send a body to `localhost:4000/api/users/login` to get a JWT token. On the seeds there already is an account, you can login with:

  ```
  {
    "email": "test@example.com",
    "password": "lol123456789"
  }
  ```
  
Then you pass the token as Authorization Bearer to `localhost:4000/api/addresses/CEP`, replacing the CEP at the end with the one you want to search which will return their info, such as:

  ```
  # localhost:4000/api/addresses/01207000
  {
      "bairro": "Santa Efigênia",
      "cep": "01207-000",
      "complemento": "lado par",
      "ddd": "11",
      "gia": "1004",
      "ibge": "3550308",
      "localidade": "São Paulo",
      "logradouro": "Rua Santa Ifigênia",
      "siafi": "7107",
      "uf": "SP"
  }
  ```
  
Or you can send the token to `localhost:4000/api/addresses/export`, which will send an email to your authenticated email with an attached CSV file containing all addresses in the database until now. You can see this email at `localhost:4000/dev/mailbox`.
