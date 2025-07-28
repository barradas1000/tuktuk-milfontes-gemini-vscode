# SUPABASE LOGIN TROUBLESHOOTING

## Histórico de Problemas e Soluções

### 1. Erro "Failed to fetch" ao tentar login
- **Causa:** O domínio do Supabase estava incorreto nas variáveis de ambiente ou havia problemas de DNS/rede.
- **Solução:** Corrigidas as variáveis `.env` para garantir que `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` estavam corretas. Testes de ping e DNS confirmaram conectividade.

### 2. Erro `net::ERR_NAME_NOT_RESOLVED`
- **Causa:** Problema de DNS local, rede, ou variável de ambiente com domínio errado.
- **Solução:** Corrigido o domínio nas variáveis de ambiente, reiniciado o frontend e limpo o cache do navegador. Testado ping ao domínio para garantir resolução correta.

### 3. Erro 500 Internal Server Error (Database error querying schema)
- **Causa:** Inconsistência no banco de dados, user duplicado ou corrompido, triggers/policies problemáticas.
- **Solução:** Verificado que não havia users duplicados. Identificado que o erro era específico do user super admin antigo. Removido manualmente todas as referências ao user (conductors, profiles, user_roles) e depois removido de `auth.users`.

### 4. Não foi possível remover user super admin
- **Causa:** Foreign key em `conductors` referenciando o user.
- **Solução:** Atualizado o campo `user_id` em `conductors` para NULL antes de remover o profile e o user.

### 5. Atualização do super admin
- **Causa:** Necessidade de trocar o super admin para um novo email.
- **Solução:**
    1. Criado um novo utilizador pelo frontend com o email `carlosbarradas1@gmail.com`.
    2. Confirmado o email (via link enviado ou manualmente pelo painel Supabase).
    3. Executado SQL para promover o novo utilizador a super admin:
        - Atualizado o campo `is_super_admin` em `auth.users` para `true`.
        - Atualizado o profile (`public.profiles`) para `role = 'admin'` e `admin_level = 'super_admin'`.
        - Removidas roles antigas e inseridas as roles `admin` e `conductor` em `public.user_roles`.
    4. Atualizados todos os scripts, documentação e fixtures para usar `carlosbarradas1@gmail.com` como novo super admin.
    5. Verificado o login e permissões do novo super admin.

### 6. Login e permissões finais
- **Causa:** Campos do profile estavam a null após atualização de roles.
- **Solução:** Atualizado o profile para garantir `full_name`, `role` e `admin_level` corretos.

---

## Recomendações Finais
- Sempre garantir que as variáveis de ambiente estão corretas e o domínio do Supabase corresponde ao projeto.
- Ao remover users, desvincular todas as referências em tabelas relacionadas antes de apagar.
- Atualizar scripts, documentação e testes sempre que houver troca de super admin.
- Usar o painel de logs do Supabase para identificar causas de erros 500 ou problemas de autenticação.

---

**Última atualização:** 28/07/2025
