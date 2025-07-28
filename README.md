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
- `documentation/` - Documentação completa organizada por temas
- `docs/` - Documentação técnica adicional

## 📚 Documentação

A documentação completa está organizada na pasta `documentation/`:

- **[📋 01-projeto](./documentation/01-projeto/)** - Visão geral e informações do projeto
- **[🔄 02-migracao](./documentation/02-migracao/)** - Processo de migração Supabase
- **[🏗️ 03-arquitetura](./documentation/03-arquitetura/)** - Arquitetura e estrutura do sistema
- **[⚙️ 04-funcionalidades](./documentation/04-funcionalidades/)** - Funcionalidades específicas
- **[🔧 05-manutencao](./documentation/05-manutencao/)** - Guias de manutenção e desenvolvimento

Para uma visão completa, consulte o [README da documentação](./documentation/README.md).

## Funcionalidades Principais

- Rastreamento em tempo real de tuk-tuks
- Sistema de reservas
- Interface de administração
- Multi-idioma (Português, Inglês, Espanhol, etc.)

## Licença

MIT
