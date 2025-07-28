# TukTuk Milfontes Gemini

Aplicação de rastreamento e reserva de tuk-tuks em Vila Nova de Milfontes.

## Tecnologias Principais
- React 18 com TypeScript
- Vite
- React Router
- React DnD (Drag and Drop)
- Leaflet (Mapas)
- Supabase (Backend)
- Tailwind CSS

## Como Executar Localmente

1. Clone o repositório:
```bash
git clone https://github.com/barradas1000/tuktuk-milfontes-gemini-vscode.git
```

2. Instale as dependências:
```bash
cd tuktuk-milfontes-gemini-vscode
npm install
```

3. Configure as variáveis de ambiente (crie um arquivo `.env` baseado no `.env.example`)

4. Inicie o servidor de desenvolvimento:
```bash
npm run dev
```

## Estrutura do Projeto

- `src/pages/` - Componentes principais das páginas
- `src/components/` - Componentes reutilizáveis
- `src/hooks/` - Hooks customizados
- `src/lib/` - Configurações e utilitários
- `src/i18n/` - Internacionalização
- `sql/` - Scripts SQL organizados (migração, schema, backups)
- `docs/` - Documentação técnica e guias

## Funcionalidades Principais

- Rastreamento em tempo real de tuk-tuks
- Sistema de reservas
- Interface de administração
- Multi-idioma (Português, Inglês, Espanhol, etc.)

## Licença

MIT
