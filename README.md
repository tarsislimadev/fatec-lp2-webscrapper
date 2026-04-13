# Raspador de notícias

## Desafio

Você deve postar seu repositório no github sobre raspagem de dados.

O tema é livre: Raspador de notícias, Pegar o preço de cotação de algum ação, Busca de imagens da Nasa, etc...

Critérios de avaliação:

Análise do código ( 0 - 6 )

O código precisa ser claro e funcional.

Repositório ( 0 - 4 )

Todo arcabouço do projeto: arquivo README.md e arquivo requirements.txt com as bibliotecas utilizadas no seu projeto.

## Solução

Este projeto é um raspador de notícias. Ele pede ao usuário um termo de busca e uma data inicial, acessa a API do NewsAPI e mostra, no terminal, as notícias encontradas com título, descrição, link, data de publicação e fonte.

Para usar o projeto, siga estes passos:

```bash
python -m pip install -r requirements.txt
```

Depois, execute o programa:

```bash
python app.py
```

Ao rodar, informe o que você quer pesquisar e a data inicial. O projeto vai fazer a busca e exibir os resultados de forma simples.
