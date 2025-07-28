# 🗺️ GUIA DE NAVEGAÇÃO DA APLICAÇÃO

## 📍 **ONDE ENCONTRAR CADA FUNCIONALIDADE:**

### 🏠 **PÁGINA INICIAL**

- **URL:** `http://localhost:8080/`
- **Componente:** `Index.tsx`
- **O que vê:** Página inicial da aplicação

### 🔐 **LOGIN**

- **URL:** `http://localhost:8080/login`
- **Componente:** `Auth.tsx`
- **Credenciais:** `carlosbarradas1@gmail.com` (password)

### 🗺️ **MAPA DE TRACKING (Público)**

- **URL:** `http://localhost:8080/tracking`
- **Componente:** `PassengerView.tsx` → `PassengerMap.tsx`
- **O que vê:** Mapa com os 3 condutores ativos

---

## 👨‍💼 **PAINEL ADMIN** (Onde estão os 3 condutores)

### 🔗 **DUAS ROTAS DIFERENTES:**

#### **1. Rota Principal Admin:**

- **URL:** `http://localhost:8080/admin`
- **Componente:** `Admin.tsx` → `AdminDashboard` (do /components/admin/)

#### **2. Rota Admin Dashboard:**

- **URL:** `http://localhost:8080/admin/dashboard`
- **Componente:** `AdminDashboard.tsx` (do /pages/)

### 📋 **AdminConductorOverview está em:**

- **Página:** `/admin/dashboard`
- **Componente:** `AdminDashboard.tsx` → `AdminConductorOverview.tsx`
- **Secção:** "dashboard-section conductor-overview-section"

---

## 🎯 **FLUXO CORRETO PARA VER OS 3 CONDUTORES:**

### **Passo 1: Login como Admin**

1. Ir para: `http://localhost:8080/login`
2. Email: `carlosbarradas1@gmail.com`
3. Password: (sua password)

### **Passo 2: Aceder ao Painel Admin**

**Opção A:** `http://localhost:8080/admin`
**Opção B:** `http://localhost:8080/admin/dashboard`

### **Passo 3: Localizar Secção**

- Scroll down para encontrar secção **"Visão Geral dos Condutores"**
- Deve mostrar tabela com:
  - Diogo
  - Motorista Teste (Carlos)
  - Sonia

---

## 🔍 **SE NÃO VIR OS 3 CONDUTORES:**

### **Verificações:**

1. **Role correto?** - Carlos deve ser "admin"
2. **Cache limpo?** - Usar Cache Helper ou Ctrl+Shift+R
3. **Página correta?** - Deve estar em `/admin/dashboard`
4. **Console errors?** - F12 → Console para ver erros

### **Soluções:**

1. **Refresh Profile** (Cache Helper)
2. **Clear All Cache** (Cache Helper)
3. **Hard Refresh** (Ctrl+Shift+R)
4. **Login novamente**

---

## 📊 **ESTADO ATUAL CONFIRMADO:**

### **Base de Dados:**

- ✅ Carlos: role = "admin"
- ✅ 3 condutores ativos (Diogo, Carlos, Sonia)
- ✅ Políticas RLS funcionais

### **Aplicação:**

- ✅ Servidor ativo em localhost:8080
- ✅ Rotas configuradas
- ✅ Componentes sem erros

**O problema pode ser estar a olhar para o sítio errado ou problemas de cache!**
