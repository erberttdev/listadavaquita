# Documentação de Instalação e Deploy - Plataforma de Lista de Presentes

## Requisitos do Sistema

- Python 3.8+
- PostgreSQL 12+
- pip (gerenciador de pacotes Python)
- Git (opcional, para clonar o repositório)
- Conta Stripe para processamento de pagamentos

## Instalação Local

### 1. Configuração do Ambiente

```bash
# Clonar o repositório (ou descompactar o arquivo zip fornecido)
git clone <url-do-repositorio> giftlist
cd giftlist

# Criar ambiente virtual
python -m venv venv

# Ativar ambiente virtual
# No Windows:
venv\Scripts\activate
# No Linux/Mac:
source venv/bin/activate

# Instalar dependências
pip install -r requirements.txt
```

### 2. Configuração do Banco de Dados

```bash
# Criar banco de dados PostgreSQL
sudo -u postgres psql

postgres=# CREATE DATABASE giftlist_db;
postgres=# CREATE USER giftlist_user WITH PASSWORD 'sua_senha_segura';
postgres=# ALTER ROLE giftlist_user SET client_encoding TO 'utf8';
postgres=# ALTER ROLE giftlist_user SET default_transaction_isolation TO 'read committed';
postgres=# ALTER ROLE giftlist_user SET timezone TO 'UTC';
postgres=# GRANT ALL PRIVILEGES ON DATABASE giftlist_db TO giftlist_user;
postgres=# \q
```

### 3. Configuração do Arquivo .env

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```
# PostgreSQL Database Configuration
DB_NAME=giftlist_db
DB_USER=giftlist_user
DB_PASSWORD=sua_senha_segura
DB_HOST=localhost
DB_PORT=5432

# Django Secret Key
SECRET_KEY='gere_uma_chave_secreta_aleatoria'

# Stripe API Keys
STRIPE_SECRET_KEY=sk_test_sua_chave_secreta_stripe
STRIPE_PUBLISHABLE_KEY=pk_test_sua_chave_publica_stripe
STRIPE_WEBHOOK_SECRET=whsec_seu_segredo_webhook_stripe

# Debug Mode
DEBUG=False
```

Para gerar uma chave secreta Django aleatória, você pode usar:

```bash
python -c "import secrets; print(secrets.token_urlsafe(50))"
```

### 4. Aplicar Migrações e Criar Superusuário

```bash
# Aplicar migrações
python manage.py migrate

# Criar superusuário para acesso administrativo
python manage.py createsuperuser

# Coletar arquivos estáticos
python manage.py collectstatic
```

### 5. Executar o Servidor de Desenvolvimento

```bash
python manage.py runserver
```

Acesse http://127.0.0.1:8000/ para visualizar a aplicação.

## Deploy em Produção

### Opção 1: Deploy no Render.com

1. Crie uma conta no [Render.com](https://render.com/)
2. Crie um novo Web Service e conecte ao repositório Git
3. Configure as variáveis de ambiente conforme o arquivo `.env`
4. Adicione um banco de dados PostgreSQL
5. Configure o build command: `pip install -r requirements.txt && python manage.py collectstatic --noinput`
6. Configure o start command: `gunicorn giftlist_project.wsgi:application`

### Opção 2: Deploy no Fly.io

1. Instale a CLI do Fly.io e faça login
2. Na raiz do projeto, execute:
   ```bash
   fly launch
   ```
3. Siga as instruções para configurar o aplicativo
4. Configure as variáveis de ambiente:
   ```bash
   fly secrets set SECRET_KEY="sua_chave_secreta" \
                  STRIPE_SECRET_KEY="sk_test_..." \
                  STRIPE_PUBLISHABLE_KEY="pk_test_..." \
                  STRIPE_WEBHOOK_SECRET="whsec_..."
   ```
5. Crie um banco de dados PostgreSQL:
   ```bash
   fly postgres create
   ```
6. Conecte o banco de dados ao aplicativo:
   ```bash
   fly postgres attach --app seu-app-name nome-do-banco
   ```
7. Implante o aplicativo:
   ```bash
   fly deploy
   ```

## Configuração do Stripe

1. Crie uma conta no [Stripe](https://stripe.com/)
2. Obtenha suas chaves de API no painel do Stripe
3. Configure o webhook no painel do Stripe:
   - URL: `https://seu-dominio.com/stripe-webhook/`
   - Eventos a escutar: `checkout.session.completed`, `payment_intent.succeeded`, `payment_intent.payment_failed`
4. Obtenha o segredo do webhook e adicione-o ao arquivo `.env`

## Manutenção e Backup

### Backup do Banco de Dados

```bash
pg_dump -U giftlist_user -d giftlist_db > backup_$(date +%Y%m%d).sql
```

### Restauração do Banco de Dados

```bash
psql -U giftlist_user -d giftlist_db < backup_arquivo.sql
```

## Solução de Problemas Comuns

1. **Erro de conexão com o banco de dados**
   - Verifique se o PostgreSQL está em execução
   - Confirme as credenciais no arquivo `.env`
   - Verifique permissões do usuário do banco

2. **Erro no processamento de pagamentos**
   - Verifique as chaves da API do Stripe
   - Confirme se o webhook está configurado corretamente
   - Verifique os logs do Stripe para detalhes do erro

3. **Problemas com scraping**
   - Os sites podem mudar sua estrutura HTML, necessitando atualização do código de scraping
   - Verifique se os seletores CSS/XPath ainda são válidos

## Contato e Suporte

Para suporte adicional, entre em contato através do email: seu-email@exemplo.com
