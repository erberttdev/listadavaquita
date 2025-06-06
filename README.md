# README - Plataforma de Lista de Presentes com Vaquinha Colaborativa

## Visão Geral

Esta plataforma permite que usuários criem listas de presentes para eventos (aniversários, casamentos, chás de bebê, etc.) e compartilhem com amigos e familiares. Os convidados podem contribuir financeiramente para os presentes através de um sistema de vaquinha colaborativa, com pagamentos processados via Stripe (cartão de crédito e Pix).

## Funcionalidades Principais

### Para o Criador da Lista
- Cadastro e login de usuários
- Criação e gerenciamento de eventos
- Adição de presentes com extração automática de dados (scraping) de lojas online
- Dashboard para acompanhamento de contribuições
- Link compartilhável para a lista de presentes
- Recebimento de contribuições via Stripe (Pix e cartão)

### Para o Contribuinte
- Acesso à lista de presentes sem necessidade de login
- Visualização de presentes, valores e progresso da vaquinha
- Contribuição financeira para presentes (requer login)
- Pagamento seguro via Stripe (Pix e cartão)
- Possibilidade de deixar mensagem personalizada

## Tecnologias Utilizadas

- **Backend**: Python 3.11, Django 5.2
- **Banco de Dados**: PostgreSQL
- **Frontend**: Bootstrap 5, HTML5, CSS3, JavaScript
- **Pagamentos**: Stripe API (Pix e cartão)
- **Scraping**: Requests, BeautifulSoup4
- **Autenticação**: Django Authentication System

## Estrutura do Projeto

```
giftlist_project/
├── core/                   # Aplicativo principal
│   ├── admin.py            # Configuração do admin Django
│   ├── forms.py            # Formulários
│   ├── models.py           # Modelos de dados
│   ├── scraper.py          # Módulo de scraping
│   ├── urls.py             # Rotas da aplicação
│   └── views.py            # Views e lógica de negócio
├── giftlist_project/       # Configurações do projeto
│   ├── settings.py         # Configurações Django
│   ├── urls.py             # Rotas principais
│   └── wsgi.py             # Configuração WSGI
├── static/                 # Arquivos estáticos
├── templates/              # Templates HTML
│   ├── base.html           # Template base
│   ├── dashboard.html      # Dashboard do usuário
│   ├── event_detail.html   # Página da lista de presentes
│   └── ...                 # Outros templates
├── .env                    # Variáveis de ambiente (não versionado)
├── .gitignore              # Arquivos ignorados pelo Git
├── manage.py               # Script de gerenciamento Django
├── requirements.txt        # Dependências do projeto
├── installation_guide.md   # Guia de instalação e deploy
└── validation_report.md    # Relatório de validação
```

## Instalação e Deploy

Consulte o arquivo `installation_guide.md` para instruções detalhadas sobre como instalar e fazer deploy da aplicação.

## Validação e Testes

Consulte o arquivo `validation_report.md` para informações sobre os testes realizados e validação das funcionalidades.

## Melhorias Futuras

- Login social (Google, Facebook)
- Geração de QR Code para compartilhamento
- Envio de e-mails de confirmação
- Painel administrativo mais completo
- Suporte a mais lojas para scraping
- API REST para integração com apps mobile

## Licença

Este projeto é licenciado sob a licença MIT - veja o arquivo LICENSE para detalhes.

## Contato

Para suporte ou dúvidas, entre em contato através do email: erbertt@gmail.com
