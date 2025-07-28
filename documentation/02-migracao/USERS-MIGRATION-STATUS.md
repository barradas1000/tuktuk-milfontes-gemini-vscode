## ⚠️ MIGRAÇÃO DE USERS INCOMPLETA

**Status:** Os dados das tabelas (`tour_types`, `conductors`, `reservations`) foram migrados com sucesso, mas os **auth.users** não foram migrados.

### 🔍 Situação Atual:
- ✅ Todas as tabelas criadas
- ✅ Dados das tabelas públicas migrados (6 tour_types, 3 conductors, 3 reservations)
- ❌ **Auth.users não migrados** - As tabelas `conductors` referenciam user_ids que não existem em auth.users

### 👥 Users que precisam ser criados:
1. **c2b84b4e-ecbf-47d1-adc0-f3d7549829b3** - Motorista Teste
2. **c4c9a172-92c2-410e-a671-56b443fc093d** - Sonia  
3. **e4b3296c-13eb-4faa-aead-e246ddb2bf66** - Diogo

### 🔧 Como resolver:

#### Opção 1: Recriar users manualmente (Recomendado)
1. Vá ao **Supabase Dashboard** > **Authentication** > **Users**
2. Crie cada user manualmente com:
   - Email: `motorista.teste@tuktuk-milfontes.pt`, `sonia@tuktuk-milfontes.pt`, `diogo@tuktuk-milfontes.pt`
   - Password temporária (eles podem alterar depois)
   - Copie os IDs gerados e atualize a tabela `conductors`

#### Opção 2: Atualizar referências (Alternativo)
1. Crie novos users
2. Atualize os `user_id` na tabela `conductors` para os novos IDs
3. Execute o script `migrate-users.sql` com os novos IDs

#### Opção 3: Manter IDs específicos (Avançado)
Use a API do Supabase para criar users com IDs específicos via backend.

### 📋 Scripts prontos:
- `migrate-users.sql` - Profiles e user_roles (executar após criar auth.users)
- `backup-data-*.sql` - Todos os dados já migrados

### ⚡ Próximo passo:
Escolha uma das opções acima para completar a migração dos users de autenticação.
