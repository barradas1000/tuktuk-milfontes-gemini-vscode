# 📋 TukTuk Milfontes - Visão Geral do Projeto

## 🎯 Descrição do Sistema

O **TukTuk Milfontes** é uma aplicação web moderna de rastreamento e reserva de tuk-tuks em Vila Nova de Milfontes, Portugal. O sistema permite gestão completa de condutores, reservas e rastreamento em tempo real.

## 🛠️ Stack Tecnológico

### Frontend
- **React 18** com **TypeScript** - Interface de utilizador moderna
- **Vite** - Build tool rápido e eficiente
- **Tailwind CSS** - Styling responsivo e moderno
- **React Router** - Navegação entre páginas
- **React DnD** - Funcionalidade drag-and-drop
- **Leaflet** - Mapas interativos e rastreamento

### Backend & Database
- **Supabase** - Backend-as-a-Service completo
- **PostgreSQL** - Base de dados principal
- **Row Level Security (RLS)** - Segurança granular
- **Real-time subscriptions** - Atualizações em tempo real

### Infraestrutura
- **Vercel** - Deployment e hosting
- **GitHub Actions** - CI/CD
- **Environment Variables** - Configuração segura

## 🏗️ Arquitetura do Sistema

### Estrutura de Pastas
```
tuktuk-milfontes-gemini/
├── src/                          # Código fonte da aplicação
│   ├── pages/                    # Páginas principais
│   ├── components/               # Componentes reutilizáveis
│   ├── hooks/                    # Custom React hooks
│   ├── lib/                      # Configurações e utilitários
│   ├── i18n/                     # Internacionalização
│   └── types/                    # Definições TypeScript
├── sql/                          # Scripts SQL organizados
├── documentation/                # Documentação organizada
├── docs/                         # Documentação técnica adicional
├── public/                       # Assets estáticos
├── supabase/                     # Configurações Supabase
└── scripts/                      # Scripts de automação
```

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Node.js 18+ instalado
- Conta Supabase configurada
- Git instalado

### Instalação
```bash
# 1. Clone o repositório
git clone https://github.com/barradas1000/tuktuk-milfontes-gemini-vscode.git
cd tuktuk-milfontes-gemini-vscode

# 2. Instale dependências
npm install

# 3. Configure variáveis de ambiente
cp .env.example .env.local
# Edite .env.local com suas credenciais Supabase

# 4. Execute em desenvolvimento
npm run dev

# 5. Acesse a aplicação
# http://localhost:5173
```

### Variáveis de Ambiente Necessárias
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 🎭 Funcionalidades Principais

### Para Clientes
- **🗺️ Rastreamento em Tempo Real** - Ver localização dos tuk-tuks
- **📅 Sistema de Reservas** - Agendar tours e transfers
- **🌍 Multi-idioma** - Português, Inglês, Espanhol, etc.
- **📱 Interface Responsiva** - Funciona em desktop e mobile

### Para Condutores
- **📍 Atualização de Localização** - GPS automático
- **📋 Gestão de Reservas** - Ver e aceitar reservas
- **⏰ Controle de Disponibilidade** - Definir horários de trabalho
- **📊 Dashboard Pessoal** - Estatísticas e histórico

### Para Administradores
- **👥 Gestão de Condutores** - Adicionar, editar, remover
- **🗓️ Calendário Administrativo** - Visão geral de reservas
- **📈 Relatórios e Analytics** - Métricas de performance
- **⚙️ Configurações do Sistema** - Tipos de tours, preços, etc.

## 🌟 Características Técnicas

### Performance
- **Lazy Loading** - Carregamento otimizado de componentes
- **Code Splitting** - Divisão automática do código
- **Caching Inteligente** - Cache de dados e assets
- **Service Workers** - Funcionalidade offline básica

### Segurança
- **Autenticação JWT** - Via Supabase Auth
- **Row Level Security** - Proteção de dados granular
- **HTTPS Obrigatório** - Comunicação segura
- **Sanitização de Inputs** - Prevenção de XSS

### Internacionalização
- **i18next** - Sistema de traduções
- **Detecção Automática** - Idioma baseado no browser
- **Fallback Inteligente** - Português como idioma padrão
- **Formatação Regional** - Datas, números, moedas

## 🔄 Status Atual do Desenvolvimento

### ✅ Concluído (95%)
- ✅ Interface de utilizador completa
- ✅ Sistema de autenticação
- ✅ Rastreamento em tempo real
- ✅ Gestão de reservas
- ✅ Interface administrativa
- ✅ Migração de dados
- ✅ Sistema de permissões

### 🔄 Em Finalização (5%)
- 🔄 Migração final de utilizadores
- 🔄 Testes finais de integração
- 🔄 Documentação de utilizador

### 🎯 Próximos Passos
1. Finalizar migração de users no Supabase
2. Implementar sistema de convites para condutores
3. Testes de carga e performance
4. Deploy para produção
5. Treinamento de utilizadores

## 📞 Informações de Contato

- **Projeto**: TukTuk Milfontes Gemini
- **Repositório**: [GitHub](https://github.com/barradas1000/tuktuk-milfontes-gemini-vscode)
- **Base de Dados**: Supabase Project `iweurnqdomiqlohvaoat`
- **Ambiente**: Em desenvolvimento/migração

---

*Para informações técnicas detalhadas, consulte as outras seções da documentação.*
