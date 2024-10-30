# Etapa 1: Construção
FROM node:14 AS build

# Definir o diretório de trabalho
WORKDIR /app

# Copiar package.json e package-lock.json
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar o restante do código da aplicação
COPY . .

# Construir a aplicação (caso haja um comando de build)
# RUN npm run build

# Etapa 2: Execução
FROM node:14

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos da etapa de build
COPY --from=build /app .

# Expor a porta que a aplicação irá utilizar
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
