# 👥 Interface por Tipo de Admin - TukTuk Milfontes

## 🎯 O que cada admin verá na prática

### 👑 **SUPER ADMIN** (Carlos Barradas)

**Poder Total - Vê Tudo, Controla Tudo**

#### 📊 **Cabeçalho da Interface:**

```
🛡️ Gerenciamento de Condutores - Controle de Permissões
├── Seu Nível: [Super Admin] (badge vermelho)
├── Região: milfontes
└── Condutores Gerenciáveis: Todos
```

#### 📋 **Abas Disponíveis:**

```
[Condutores (15)] [Ativos (8)] [Auditoria (45)]
     ↑              ↑            ↑
   Todos os      Apenas os    TODOS os logs
  condutores      ativos      do sistema
```

#### 👥 **Aba "Condutores":**

```
┌─────────────────────────────────────────────────────────┐
│ 📋 Lista de Condutores                                  │
├─────────────────────────────────────────────────────────┤
│ João Silva                               [Ativo]        │
│ +351 966 123 456 • milfontes                           │
│                              [🔴 Desativar] ← PODE     │
├─────────────────────────────────────────────────────────┤
│ Maria Santos                            [Inativo]       │
│ +351 966 789 123 • vila_nova_milfontes                 │
│                              [✅ Ativar] ← PODE        │
├─────────────────────────────────────────────────────────┤
│ Pedro Costa                              [Ativo]        │
│ +351 966 456 789 • odemira                             │
│                              [🔴 Desativar] ← PODE     │
└─────────────────────────────────────────────────────────┘
```

#### 👁️ **Aba "Ativos":**

```
┌─────────────────┬─────────────────┬─────────────────┐
│ João Silva      │ Maria Costa     │ Ana Ferreira    │
│ +351 966 123    │ +351 966 456    │ +351 966 789    │
│ [milfontes]     │ [milfontes]     │ [odemira]       │
│ [Ativo]         │ [Ativo]         │ [Ativo]         │
│ [🔴 Desativar]  │ [🔴 Desativar]  │ [🔴 Desativar]  │
└─────────────────┴─────────────────┴─────────────────┘
```

#### 📊 **Aba "Auditoria" (EXCLUSIVA):**

```
┌─────────────────────────────────────────────────────────┐
│ ⚠️ Log de Auditoria                                    │
├─────────────────────────────────────────────────────────┤
│ ⚠️ Desativação de condutor                             │
│ 21/07/2025 15:30 • milfontes                          │
│                            [Admin Regional] Ana Silva  │
│                            Motivo: Manutenção veículo  │
├─────────────────────────────────────────────────────────┤
│ ✅ Ativação de condutor                               │
│ 21/07/2025 14:15 • odemira                            │
│                            [Super Admin] Carlos        │
├─────────────────────────────────────────────────────────┤
│ ⚠️ Desativação de condutor                             │
│ 21/07/2025 13:45 • milfontes                          │
│                            [Admin Local] João Admin    │
│                            Motivo: Fim do turno        │
└─────────────────────────────────────────────────────────┘
```

---

### 🔵 **ADMIN REGIONAL** (Exemplo: Ana Silva - Região Milfontes)

**Poder Regional - Só a Sua Região**

#### 📊 **Cabeçalho da Interface:**

```
🛡️ Gerenciamento de Condutores - Controle de Permissões
├── Seu Nível: [Admin Regional] (badge azul)
├── Região: milfontes
└── Condutores Gerenciáveis: Região: milfontes
```

#### 📋 **Abas Disponíveis:**

```
[Condutores (8)] [Ativos (5)] ❌ [Auditoria]
     ↑              ↑            ↑
  Só região      Só região    NÃO VÊ
  milfontes      milfontes   (sem aba)
```

#### 👥 **Aba "Condutores" (FILTRADA):**

```
┌─────────────────────────────────────────────────────────┐
│ 📋 Lista de Condutores                                  │
├─────────────────────────────────────────────────────────┤
│ João Silva                               [Ativo]        │
│ +351 966 123 456 • milfontes                           │
│                              [🔴 Desativar] ← PODE     │
├─────────────────────────────────────────────────────────┤
│ Maria Santos                            [Inativo]       │
│ +351 966 789 123 • milfontes                           │
│                              [✅ Ativar] ← PODE        │
├─────────────────────────────────────────────────────────┤
│ ❌ Pedro Costa (odemira) - NÃO APARECE                 │
│ ❌ Ana Ferreira (vila_nova) - NÃO APARECE              │
└─────────────────────────────────────────────────────────┘
```

#### 🚫 **O que NÃO vê:**

- Condutores de outras regiões (odemira, vila_nova_milfontes)
- Aba de Auditoria
- Logs de outros admins
- Botões para condutores de outras regiões

---

### 🟢 **ADMIN LOCAL** (Exemplo: João Admin - Área Específica)

**Poder Muito Limitado - Só Área Local**

#### 📊 **Cabeçalho da Interface:**

```
🛡️ Gerenciamento de Condutores - Controle de Permissões
├── Seu Nível: [Admin Local] (badge verde)
├── Região: milfontes_centro
└── Condutores Gerenciáveis: Região: milfontes_centro
```

#### 📋 **Abas Disponíveis:**

```
[Condutores (3)] [Ativos (2)] ❌ [Auditoria]
     ↑              ↑            ↑
 Só 3 locais    Só 2 ativos   NÃO VÊ
   da área        da área    (sem aba)
```

#### 👥 **Aba "Condutores" (MUITO LIMITADA):**

```
┌─────────────────────────────────────────────────────────┐
│ 📋 Lista de Condutores                                  │
├─────────────────────────────────────────────────────────┤
│ Carlos Local                             [Ativo]        │
│ +351 966 111 222 • milfontes_centro                    │
│                              [🔴 Desativar] ← PODE     │
├─────────────────────────────────────────────────────────┤
│ Sofia Centro                            [Inativo]       │
│ +351 966 333 444 • milfontes_centro                    │
│                              [✅ Ativar] ← PODE        │
├─────────────────────────────────────────────────────────┤
│ ❌ João Silva (milfontes) - NÃO APARECE                │
│ ❌ Maria Santos (milfontes) - NÃO APARECE              │
│ ❌ Pedro Costa (odemira) - NÃO APARECE                 │
└─────────────────────────────────────────────────────────┘
```

#### 🚫 **O que NÃO vê:**

- Condutores de outras áreas (mesmo dentro de milfontes)
- Aba de Auditoria
- Logs de sistema
- Botões desabilitados com "Sem Permissão"

---

## 🔒 **Verificação de Permissões em Tempo Real**

### ✅ **Para Condutores com Permissão:**

```html
<button variant="destructive">🔴 Desativar</button>
<!-- ou -->
<button variant="default">✅ Ativar</button>
```

### ❌ **Para Condutores sem Permissão:**

```html
<Badge variant="outline" className="bg-gray-100"> Sem Permissão </Badge>
```

### 🔄 **Modal de Confirmação (Para todos com permissão):**

```
┌─────────────────────────────────────────┐
│ ⚠️ Confirmar Alteração                  │
├─────────────────────────────────────────┤
│ Deseja alterar o status deste condutor? │
│                                         │
│ Motivo (opcional):                      │
│ ┌─────────────────────────────────────┐ │
│ │ Fim do turno                        │ │
│ │                                     │ │
│ └─────────────────────────────────────┘ │
│                                         │
│           [Cancelar] [Confirmar]        │
└─────────────────────────────────────────┘
```

---

## 📱 **Responsividade por Tipo**

### 📟 **Mobile - Super Admin:**

- 3 abas: Condutores, Ativos, Auditoria
- Scroll horizontal nos cards
- Todos os controles disponíveis

### 📟 **Mobile - Admin Regional:**

- 2 abas: Condutores, Ativos
- Apenas região específica
- Sem aba de auditoria

### 📟 **Mobile - Admin Local:**

- 2 abas: Condutores, Ativos
- Lista muito reduzida
- Controles limitados

---

## 🎨 **Códigos de Cores por Nível**

```css
/* Super Admin */
.super_admin {
  background: #fef2f2;
  color: #991b1b;
  border: #fecaca;
}

/* Admin Regional */
.admin_regional {
  background: #eff6ff;
  color: #1e40af;
  border: #dbeafe;
}

/* Admin Local */
.admin_local {
  background: #f0fdf4;
  color: #166534;
  border: #bbf7d0;
}
```

**Em resumo: Cada admin vê EXATAMENTE o que pode controlar, com interface adaptada ao seu nível de permissão!** 🎯
