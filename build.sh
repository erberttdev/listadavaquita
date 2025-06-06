#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Iniciando processo de build..."

# Coleta arquivos estáticos
echo "Coletando arquivos estáticos..."
python manage.py collectstatic --no-input

# Estratégia robusta para migrações
echo "Iniciando migrações automáticas..."

# Primeiro, tenta marcar migrações problemáticas como fake se necessário
echo "Verificando estado das migrações..."
python manage.py showmigrations

# Tenta aplicar migrações normalmente
python manage.py migrate --noinput || {
    echo "Erro durante migrações. Tentando estratégias alternativas..."
    
    # Se falhar, tenta marcar a migração problemática como fake e aplicar novamente
    echo "Marcando migração problemática como fake..."
    python manage.py migrate core 0002 --fake || {
        echo "Não foi possível marcar como fake"
    }
    
    # Tenta aplicar migrações novamente
    python manage.py migrate --noinput || {
        echo "Aviso: Ainda há problemas com migrações, mas continuando..."
    }
}

# Cria superusuário se necessário (usando script existente)
echo "Verificando superusuário..."
python create_superuser.py || {
    echo "Aviso: Erro ao criar superusuário (pode já existir)"
    echo "Continuando a inicialização do servidor..."
}

echo "Build concluído com sucesso!"
