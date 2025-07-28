# 🎯 EXECUÇÃO DOS PRÓXIMOS PASSOS - TUKTUK MILFONTES

## 📋 Plano de Execução Pós-Migração

Seguindo o roadmap definido no script `MIGRACAO-FINAL-DEFINITIVA.sql`, vamos executar cada passo sistematicamente.

### ✅ **PASSO 1: Testar Login na Aplicação**

#### 🔑 Credenciais para Teste:
```
👨‍💼 Condutor 1:
Email: motorista.teste@tuktuk-milfontes.pt
Password: TukTuk2025!

👩‍💼 Condutor 2:
Email: sonia@tuktuk-milfontes.pt
Password: TukTuk2025!

👨‍💼 Condutor 3:
Email: diogo@tuktuk-milfontes.pt
Password: TukTuk2025!
```

#### 🧪 Processo de Teste:
1. **Aceder à aplicação** em desenvolvimento ou produção
2. **Testar login** com cada conta
3. **Verificar permissões** de cada role
4. **Confirmar dados do perfil** estão corretos
5. **Testar funcionalidades específicas** de condutores

#### ✅ Lista de Verificação Login:
- [ ] Login com motorista.teste@tuktuk-milfontes.pt funciona
- [ ] Login com sonia@tuktuk-milfontes.pt funciona  
- [ ] Login com diogo@tuktuk-milfontes.pt funciona
- [ ] Perfis carregam corretamente
- [ ] Permissões de condutor ativas
- [ ] Interface de condutor acessível
- [ ] Dados pessoais corretos

---

### 📧 **PASSO 2: Enviar Credenciais para Condutores**

#### 📝 Template de Email:
```html
Assunto: 🚗 TukTuk Milfontes - Suas Credenciais de Acesso

Olá [NOME],

O sistema TukTuk Milfontes foi migrado com sucesso! 

🔑 SUAS CREDENCIAIS DE ACESSO:
━━━━━━━━━━━━━━━━━━━━━━━━━━
📧 Email: [EMAIL]
🔐 Password: TukTuk2025!
🌐 Link: https://tuktuk-milfontes.vercel.app

⚠️ IMPORTANTE:
• Esta é uma password temporária
• Altere a password no primeiro login
• Guarde as suas credenciais em segurança

🎯 PRÓXIMOS PASSOS:
1. Acesse o link acima
2. Faça login com as credenciais
3. Altere sua password
4. Complete seu perfil
5. Teste as funcionalidades

📞 SUPORTE:
Em caso de dúvidas, contacte a administração.

Bem-vindo ao novo sistema!
Equipe TukTuk Milfontes 🚗
```

#### 📮 Processo de Envio:
1. **Personalizar template** para cada condutor
2. **Enviar emails individuais**
3. **Confirmar recebimento**
4. **Acompanhar primeiro acesso**

---

### 🔄 **PASSO 3: Implementar Sistema de Convites**

#### 🏗️ Arquitetura do Sistema de Convites:

**Nova Tabela - conductor_invitations:**
```sql
CREATE TABLE conductor_invitations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    invitation_token VARCHAR(255) UNIQUE NOT NULL,
    invited_by UUID REFERENCES auth.users(id),
    status VARCHAR(20) DEFAULT 'pending', -- pending, accepted, expired
    expires_at TIMESTAMP DEFAULT (now() + INTERVAL '7 days'),
    created_at TIMESTAMP DEFAULT now(),
    accepted_at TIMESTAMP,
    notes TEXT
);
```

**Fluxo do Convite:**
```
1. Admin → Criar Convite
2. Sistema → Gerar Token
3. Sistema → Enviar Email
4. Condutor → Clicar Link
5. Condutor → Criar Conta
6. Sistema → Ativar Permissões
```

#### 🔧 Implementação Frontend:
```typescript
// Hook para gerir convites
const useInvitations = () => {
  const sendInvitation = async (conductorData: NewConductor) => {
    const { data, error } = await supabase
      .from('conductor_invitations')
      .insert({
        email: conductorData.email,
        full_name: conductorData.name,
        phone: conductorData.phone,
        invitation_token: generateToken(),
        invited_by: user.id
      });
    
    if (!error) {
      await sendInvitationEmail(data.email, data.invitation_token);
    }
    
    return { data, error };
  };
  
  return { sendInvitation };
};

// Componente de convite
const InviteConductorForm = () => {
  const { sendInvitation } = useInvitations();
  
  const handleSubmit = async (formData) => {
    await sendInvitation(formData);
    toast.success('Convite enviado com sucesso!');
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input name="name" placeholder="Nome completo" required />
      <input name="email" type="email" placeholder="Email" required />
      <input name="phone" placeholder="Telefone" />
      <textarea name="notes" placeholder="Notas adicionais" />
      <button type="submit">Enviar Convite</button>
    </form>
  );
};
```

---

### 🧪 **PASSO 4: Testar Todas as Funcionalidades**

#### 📋 Lista de Testes Completa:

**Autenticação:**
- [ ] Login/logout de condutores
- [ ] Login/logout de admins
- [ ] Recuperação de password
- [ ] Sessões persistentes

**Rastreamento:**
- [ ] Atualização de localização GPS
- [ ] Visualização em tempo real no mapa
- [ ] Status online/offline
- [ ] Histórico de localizações

**Reservas:**
- [ ] Criar nova reserva
- [ ] Atribuir condutor
- [ ] Alterar status da reserva
- [ ] Cancelar reserva
- [ ] Relatórios de reservas

**Interface Admin:**
- [ ] Dashboard administrativo
- [ ] Gestão de condutores
- [ ] Calendário de reservas
- [ ] Relatórios e estatísticas

**Permissões:**
- [ ] Acesso baseado em roles
- [ ] Proteção de rotas
- [ ] Políticas RLS
- [ ] Segregação de dados

#### 🔬 Script de Teste Automatizado:
```typescript
// cypress/integration/migration-tests.spec.ts
describe('Migração TukTuk Tests', () => {
  const conductors = [
    { email: 'motorista.teste@tuktuk-milfontes.pt', password: 'TukTuk2025!' },
    { email: 'sonia@tuktuk-milfontes.pt', password: 'TukTuk2025!' },
    { email: 'diogo@tuktuk-milfontes.pt', password: 'TukTuk2025!' }
  ];
  
  conductors.forEach(conductor => {
    it(`should login as ${conductor.email}`, () => {
      cy.visit('/login');
      cy.get('[data-testid=email]').type(conductor.email);
      cy.get('[data-testid=password]').type(conductor.password);
      cy.get('[data-testid=login-btn]').click();
      cy.url().should('include', '/dashboard');
      cy.contains('Bem-vindo').should('be.visible');
    });
  });
});
```

---

### 🗑️ **PASSO 5: Desativar Projeto Antigo**

#### ⚠️ Processo de Desativação Segura:

**Pré-requisitos para Desativação:**
- [ ] ✅ Todos os testes passaram
- [ ] ✅ Condutores confirmaram acesso
- [ ] ✅ Backup final criado
- [ ] ✅ Sistema novo 100% funcional
- [ ] ✅ Período de teste de 1 semana completo

**Passos de Desativação:**
1. **Backup Final** do projeto antigo
2. **Redirect DNS** (se aplicável)
3. **Desativar APIs** antigas
4. **Arquivar Projeto** no Supabase
5. **Documentar** processo de rollback (emergência)

#### 📋 Checklist de Desativação:
```sql
-- Script de backup final
-- Execute no projeto ANTIGO (cqnahwnnqzraqcslljaz)
\copy (SELECT * FROM auth.users) TO '/backup/final_users.csv' CSV HEADER;
\copy (SELECT * FROM public.profiles) TO '/backup/final_profiles.csv' CSV HEADER;
\copy (SELECT * FROM public.conductors) TO '/backup/final_conductors.csv' CSV HEADER;
-- ... outros backups
```

---

### 🔐 **PASSO 6: Implementar Redefinição de Passwords**

#### 🔄 Fluxo de Primeira Autenticação:

```typescript
// Hook para primeiro login
const useFirstLogin = () => {
  const checkFirstLogin = async () => {
    const { data: profile } = await supabase
      .from('profiles')
      .select('first_login_completed')
      .eq('id', user.id)
      .single();
    
    return !profile?.first_login_completed;
  };
  
  const completeFirstLogin = async (newPassword: string) => {
    // Atualizar password
    await supabase.auth.updateUser({ password: newPassword });
    
    // Marcar primeiro login como completo
    await supabase
      .from('profiles')
      .update({ first_login_completed: true })
      .eq('id', user.id);
  };
  
  return { checkFirstLogin, completeFirstLogin };
};

// Componente de redefinição obrigatória
const ForcePasswordChange = () => {
  const { completeFirstLogin } = useFirstLogin();
  
  const handlePasswordChange = async (formData) => {
    await completeFirstLogin(formData.newPassword);
    router.push('/dashboard');
    toast.success('Password atualizada com sucesso!');
  };
  
  return (
    <div className="force-password-change">
      <h2>Primeira vez? Altere sua password</h2>
      <PasswordChangeForm onSubmit={handlePasswordChange} />
    </div>
  );
};
```

---

## 🎯 **Status de Execução**

### ✅ Próximos Passos Imediatos:
1. **🔍 VERIFICAR** se migração foi executada com sucesso
2. **🧪 TESTAR** login das 3 contas
3. **📧 PREPARAR** emails para condutores
4. **🔧 IMPLEMENTAR** sistema de convites
5. **📋 EXECUTAR** bateria de testes completa

### 📅 Timeline Sugerida:
- **Hoje**: Testes de login e verificação
- **Amanhã**: Envio de credenciais e primeiros testes
- **Esta semana**: Implementação de convites
- **Próxima semana**: Testes finais e desativação do antigo

---

**🎯 Pronto para começar! Qual passo quer executar primeiro?**
