# 🏗️ Arquitetura do Sistema - TukTuk Milfontes

## 🗄️ Estrutura da Base de Dados

### 📊 Schema Completo (15 Tabelas)

O sistema utiliza **PostgreSQL via Supabase** com **Row Level Security (RLS)** para segurança granular.

#### 👥 **Gestão de Utilizadores**
```sql
auth.users              -- Autenticação Supabase (gerida automaticamente)
├── public.profiles     -- Perfis detalhados dos utilizadores
└── public.user_roles   -- Papéis e permissões
```

#### 🚗 **Gestão de Condutores**
```sql
public.conductors              -- Informações dos condutores
├── public.conductor_locations -- Localizações em tempo real
├── public.active_conductors   -- Status de atividade
├── public.conductor_status_audit -- Auditoria de mudanças
└── public.conductor_applications -- Candidaturas para condutores
```

#### 🎫 **Sistema de Reservas**
```sql
public.tour_types    -- Tipos de tours disponíveis
├── public.reservations -- Reservas dos clientes
└── public.blocked_periods -- Períodos indisponíveis
```

#### 🚙 **Gestão de Veículos**
```sql
public.tuktuks         -- Informações dos tuk-tuks
└── public.tuktuk_vehicles -- Detalhes técnicos dos veículos
```

#### ⚙️ **Sistema Administrativo**
```sql
public.admin_calendar_events -- Eventos do calendário admin
├── public.notifications     -- Sistema de notificações
└── public.system_settings   -- Configurações globais
```

## 🔐 Sistema de Autenticação

### 🎭 Hierarquia de Papéis

```
🔴 SUPER_ADMIN (Nível 5)
├── Acesso total ao sistema
└── Gestão de administradores

🟠 ADMIN_GLOBAL (Nível 4) 
├── Gestão completa de condutores
├── Configurações do sistema
└── Relatórios avançados

🟡 ADMIN_LOCAL (Nível 3)
├── Gestão de condutores locais
├── Calendário administrativo
└── Reservas da região

🟢 CONDUCTOR (Nível 2)
├── Atualização de localização
├── Gestão de disponibilidade
└── Visualização de reservas

🔵 USER (Nível 1)
├── Visualização de tuk-tuks
├── Criação de reservas
└── Perfil básico
```

### 🛡️ Row Level Security (RLS)

#### Políticas de Segurança Implementadas:

**Profiles Table:**
```sql
-- Utilizadores só acedem ao próprio perfil
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

-- Admins acedem a todos os perfis
CREATE POLICY "Admins can view all profiles" ON profiles
  FOR SELECT USING (
    auth.jwt() ->> 'role' IN ('admin_global', 'admin_local')
  );
```

**Conductors Table:**
```sql
-- Condutores acedem aos próprios dados
CREATE POLICY "Conductors can view own data" ON conductors
  FOR SELECT USING (user_id = auth.uid());

-- Admins acedem a todos os condutores
CREATE POLICY "Admins can manage conductors" ON conductors
  FOR ALL USING (
    auth.jwt() ->> 'role' IN ('admin_global', 'admin_local')
  );
```

## 🗺️ Sistema de Rastreamento

### 📍 Localização em Tempo Real

**Arquitetura:**
```
📱 App Condutor → 📡 Supabase Realtime → 🗺️ Mapa Cliente
    ↓                      ↓                    ↓
GPS Location    Real-time Subscription    Live Updates
  (1-5s)            (WebSocket)           (Instant)
```

**Tabela de Localizações:**
```sql
conductor_locations:
├── conductor_id (UUID) -- Referência ao condutor
├── latitude (DECIMAL)  -- Coordenada GPS
├── longitude (DECIMAL) -- Coordenada GPS
├── accuracy (INTEGER)  -- Precisão em metros
├── speed (DECIMAL)     -- Velocidade atual
├── heading (DECIMAL)   -- Direção (0-360°)
├── is_active (BOOLEAN) -- Status de atividade
└── updated_at (TIMESTAMP) -- Última atualização
```

### 🎯 Sistema de Cache Inteligente

**Estratégia Multi-Camada:**
```
🔄 Browser Cache (60s) 
    ↓
💾 Supabase Cache (30s)
    ↓  
🗄️ PostgreSQL (Real-time)
```

**Implementação:**
- **Locations**: Cache de 30 segundos
- **Static Data**: Cache de 24 horas
- **User Profiles**: Cache até logout
- **Reservations**: Real-time (sem cache)

## 🎨 Arquitetura Frontend

### 📱 Estrutura React

```
src/
├── pages/              # Páginas principais
│   ├── Home.tsx       # Dashboard principal
│   ├── Admin/         # Interface administrativa
│   ├── Conductor/     # Interface do condutor
│   └── Tracking/      # Rastreamento em tempo real
├── components/        # Componentes reutilizáveis
│   ├── Map/          # Componentes de mapa
│   ├── Auth/         # Autenticação
│   ├── UI/           # Interface básica
│   └── Forms/        # Formulários
├── hooks/            # Custom React hooks
│   ├── useAuth.ts    # Gestão de autenticação
│   ├── useLocation.ts # Gestão de localização
│   └── useRealtile.ts # Subscriptions real-time
├── lib/              # Configurações
│   ├── supabase.ts   # Cliente Supabase
│   ├── maps.ts       # Configuração de mapas
│   └── permissions.ts # Sistema de permissões
└── types/            # Definições TypeScript
```

### 🔌 Integrações Principais

**Supabase Client:**
```typescript
// Configuração central
const supabase = createClient(
  process.env.VITE_SUPABASE_URL!,
  process.env.VITE_SUPABASE_ANON_KEY!
);

// Real-time subscriptions
supabase
  .channel('conductor-locations')
  .on('postgres_changes', {
    event: 'UPDATE',
    schema: 'public',
    table: 'conductor_locations'
  }, handleLocationUpdate)
  .subscribe();
```

**Leaflet Maps:**
```typescript
// Configuração de mapas
const mapConfig = {
  center: [37.7265, -8.7831], // Vila Nova de Milfontes
  zoom: 15,
  tileLayer: 'OpenStreetMap',
  clustertMarkers: true,
  realTimeTracking: true
};
```

## 🌐 API e Endpoints

### 🔗 Supabase REST API

**Endpoints Principais:**
```
GET  /rest/v1/conductors          # Lista condutores
POST /rest/v1/reservations        # Criar reserva
GET  /rest/v1/conductor_locations # Localizações atuais
PUT  /rest/v1/profiles            # Atualizar perfil
```

**Headers Obrigatórios:**
```http
Authorization: Bearer <JWT_TOKEN>
apikey: <SUPABASE_ANON_KEY>
Content-Type: application/json
```

### 📡 Real-time Subscriptions

**Channels Configurados:**
```typescript
// Localizações em tempo real
'conductor-locations': {
  event: 'UPDATE',
  table: 'conductor_locations'
}

// Novas reservas
'reservations': {
  event: 'INSERT',
  table: 'reservations'
}

// Status de condutores
'conductor-status': {
  event: '*',
  table: 'active_conductors'
}
```

## ⚡ Performance e Otimização

### 📊 Índices da Base de Dados

```sql
-- Otimização para consultas frequentes
CREATE INDEX idx_conductor_locations_active 
  ON conductor_locations(conductor_id, is_active, updated_at);

CREATE INDEX idx_reservations_status_date 
  ON reservations(status, tour_date);

CREATE INDEX idx_profiles_role_region 
  ON profiles(role, region);
```

### 🚀 Otimizações Frontend

**Code Splitting:**
```typescript
// Lazy loading de páginas
const AdminPanel = lazy(() => import('./pages/Admin'));
const ConductorDashboard = lazy(() => import('./pages/Conductor'));
```

**Memoização:**
```typescript
// Cache de componentes pesados
const MapComponent = memo(({ locations }) => {
  // Renderização otimizada
});
```

## 🔧 Configurações de Ambiente

### 📋 Variáveis Necessárias

```env
# Supabase
VITE_SUPABASE_URL=https://iweurnqdomiqlohvaoat.supabase.co
VITE_SUPABASE_ANON_KEY=your_anon_key

# Maps
VITE_MAP_DEFAULT_LAT=37.7265
VITE_MAP_DEFAULT_LNG=-8.7831
VITE_MAP_DEFAULT_ZOOM=15

# App
VITE_APP_NAME=TukTuk Milfontes
VITE_APP_VERSION=1.0.0
```

### 🏭 Ambientes

```
🔴 PRODUCTION
├── Domain: tuktuk-milfontes.vercel.app
├── Database: iweurnqdomiqlohvaoat.supabase.co
└── Branch: main

🟡 STAGING  
├── Domain: staging-tuktuk-milfontes.vercel.app
├── Database: staging-project.supabase.co
└── Branch: develop

🔵 LOCAL
├── Domain: localhost:5173
├── Database: local-supabase (opcional)
└── Branch: feature/*
```

---

*Arquitetura robusta e escalável, pronta para crescimento futuro.*
