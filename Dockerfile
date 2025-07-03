# Etapa 1: Definir a imagem base
# Usamos uma imagem slim do Python 3.10, que é leve e contém o necessário para rodar a aplicação,
# conforme especificado no seu README.md.
FROM python:3.10-slim

# Etapa 2: Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências e instalar
# Copiamos primeiro o requirements.txt para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o restante do código da aplicação
COPY . .

# Etapa 5: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 6: Comando para executar a aplicação quando o contêiner iniciar
# Usamos uvicorn para rodar a aplicação FastAPI.
# O host 0.0.0.0 permite que a aplicação seja acessada de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]