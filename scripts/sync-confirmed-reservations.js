/* eslint-disable no-console */
const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '../.env' });

// Configuração do cliente Supabase
const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY; // Usar a chave de serviço se for necessário (mais permissões)

if (!supabaseUrl || !supabaseKey) {
  console.error('As variáveis de ambiente SUPABASE_URL e SUPABASE_KEY são obrigatórias.');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

/**
 * Script para sincronizar reservas confirmadas, garantindo que cada uma tem um bloqueio correspondente.
 * Este script deve ser executado uma única vez após a implementação da funcionalidade de bloqueio automático.
 */
async function syncConfirmedReservations() {
  console.log('A iniciar a sincronização de reservas confirmadas com os períodos de bloqueio...');

  // 1. Obter todas as reservas com o estado 'confirmed'
  const { data: reservations, error: reservationsError } = await supabase
    .from('reservations')
    .select('*')
    .eq('status', 'confirmed');

  if (reservationsError) {
    console.error('Erro ao obter as reservas:', reservationsError.message);
    return;
  }

  if (!reservations || reservations.length === 0) {
    console.log('Nenhuma reserva confirmada encontrada. Não é necessário sincronizar.');
    return;
  }

  console.log(`Encontradas ${reservations.length} reservas confirmadas para verificar.`);

  // 2. Obter todos os bloqueios existentes que foram gerados pelo sistema
  const { data: existingBlocks, error: blocksError } = await supabase
    .from('blocked_periods')
    .select('reason')
    .eq('createdBy', 'Sistema (Reserva)');

  if (blocksError) {
    console.error('Erro ao obter os bloqueios existentes:', blocksError.message);
    return;
  }

  const existingBlockReasons = new Set(existingBlocks.map(b => b.reason));
  let createdCount = 0;

  // 3. Iterar sobre cada reserva e verificar se o bloqueio correspondente já existe
  for (const reservation of reservations) {
    const expectedReason = `Reserva: ${reservation.customer_name} (ID: ${reservation.id})`;

    if (existingBlockReasons.has(expectedReason)) {
      console.log(`O bloqueio para a reserva ID ${reservation.id} já existe. A ignorar.`);
      continue;
    }

    // 4. Se não existir, criar o novo bloqueio
    console.log(`A criar bloqueio para a reserva ID ${reservation.id}...`);
    const { error: createError } = await supabase
      .from('blocked_periods')
      .insert({
        date: reservation.reservation_date,
        startTime: reservation.reservation_time,
        endTime: reservation.reservation_time,
        reason: expectedReason,
        createdBy: 'Sistema (Reserva)',
      });

    if (createError) {
      console.error(`Falha ao criar bloqueio para a reserva ID ${reservation.id}:`, createError.message);
    } else {
      createdCount++;
      console.log(`Bloqueio para a reserva ID ${reservation.id} criado com sucesso.`);
    }
  }

  console.log('\n--- Sincronização Concluída ---');
  console.log(`Total de reservas confirmadas verificadas: ${reservations.length}`);
  console.log(`Novos bloqueios criados: ${createdCount}`);
  console.log('O sistema está agora totalmente sincronizado.');
}

syncConfirmedReservations().catch(console.error);
