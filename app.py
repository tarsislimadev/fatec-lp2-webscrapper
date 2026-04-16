import requests
from bs4 import BeautifulSoup
from datetime import datetime

with open('NEWS_API_KEY.txt', 'r') as f:
  apikey = f.read().strip()

class ValidationResult:
  def __init__(self, valid, error_message=None):
    self.valid = valid
    self.error_message = error_message

  def get_error(self):
    return self.error_message

class Validator:
  def __init__(self, validate_func, error_message):
    self.validate_func = validate_func
    self.error_message = error_message

  def validate(self, value):
    if self.validate_func(value):
      return ValidationResult(True)
    else:
      return ValidationResult(False, self.error_message)
    
  def get_error(self):
    return self.error_message

def get_input(text, validator=None):
  while True:
    ret = input(text)
    if ret == '':
      continue
    if validator:
      validation = validator.validate(ret)
      if not validation.valid:
        print(validation.get_error())
      else:
        return ret

def validate_date_more_than_month_ago(date_str):
  try:
    date = datetime.strptime(date_str, '%Y-%m-%d')
    return (datetime.now() - date).days < 20
  except ValueError:
    return False

q = get_input('Busca: ', Validator(lambda x: isinstance(x, str) and len(x) > 0, "Search query cannot be empty."))

date_from = get_input('Data (< 20 dias) (YYYY-MM-DD): ', Validator(validate_date_more_than_month_ago, "Date must be more than one month ago and in YYYY-MM-DD format."))

url = 'https://newsapi.org/v2/everything?q=' + q + '&from=' + date_from + '&sortBy=publishedAt&apiKey=' + apikey

response = requests.get(url)

data = response.json()

if data['status'] == 'ok':
  articles = data['articles']
  for article in articles:
    print('Titulo:', article['title'])
    print('Descrição:', article['description'])
    print('URL:', article['url'])
    print('Publicado em:', article['publishedAt'])
    print('Fonte:', article['source']['name'])
    print('---')
else:
  print('Erro:', data['message'])
