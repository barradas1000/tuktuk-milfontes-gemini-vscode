import React, { useState, useEffect } from 'react';
import { Switch } from '@/components/ui/switch';
import { Label } from '@/components/ui/label';
import { useToast } from '@/components/ui/use-toast';
import { updateDriverTrackingStatus, getDriverTrackingStatus } from '@/services/supabaseService';

interface ToggleTrackingButtonProps {
  driverId: string;
}

const ToggleTrackingButton: React.FC<ToggleTrackingButtonProps> = ({ driverId }) => {
  const [isTrackingActive, setIsTrackingActive] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const { toast } = useToast();

  useEffect(() => {
    const fetchStatus = async () => {
      if (!driverId) {
        setIsLoading(false);
        return;
      }
      try {
        const status = await getDriverTrackingStatus(driverId);
        setIsTrackingActive(status);
      } catch (error) {
        console.error('Failed to fetch tracking status:', error);
        toast({
          title: 'Erro ao carregar status de rastreamento',
          description: 'Não foi possível carregar o status de rastreamento do condutor.',
          variant: 'destructive',
        });
      } finally {
        setIsLoading(false);
      }
    };
    fetchStatus();
  }, [driverId, toast]);

  const handleToggle = async (checked: boolean) => {
    if (!driverId) {
      return;
    }
    setIsLoading(true);
    try {
      await updateDriverTrackingStatus(driverId, checked);
      setIsTrackingActive(checked);
      toast({
        title: `Rastreamento ${checked ? 'ativado' : 'desativado'}`, 
        description: `O rastreamento para o condutor ${driverId} foi ${checked ? 'ativado' : 'desativado'} com sucesso.`, 
      });
    } catch (error) {
      console.error('Failed to update tracking status:', error);
      toast({
        title: 'Erro ao atualizar status de rastreamento',
        description: 'Não foi possível atualizar o status de rastreamento do condutor.',
        variant: 'destructive',
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="flex items-center space-x-2">
      <Switch
        id={`tracking-status-${driverId}`}
        checked={isTrackingActive}
        onCheckedChange={handleToggle}
        disabled={isLoading}
      />
      <Label htmlFor={`tracking-status-${driverId}`}>
        {isLoading ? 'Carregando...' : (isTrackingActive ? 'Rastreamento Ativo' : 'Rastreamento Inativo')}
      </Label>
    </div>
  );
};

export default ToggleTrackingButton;