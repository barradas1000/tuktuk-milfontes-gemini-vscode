import React from "react";
import { Navigate } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";

interface ProtectedRouteProps {
  children: JSX.Element;
  allowedRoles: string[];
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({
  children,
  allowedRoles,
}) => {
  const { user, profile, loading } = useAuth();

  if (loading) {
    // Ainda a carregar o estado de autenticação/perfil
    return <div>Carregando autenticação...</div>; // Ou um spinner de carregamento mais sofisticado
  }

  if (!user) {
    // Usuário não autenticado, redireciona para a página de login
    return <Navigate to="/login" replace />;
  }

  if (!profile) {
    // Usuário autenticado, mas perfil ainda não carregado ou não existe
    // Isso pode acontecer se o perfil não for criado imediatamente após o signup
    // ou se houver um erro ao buscar o perfil.
    // Pode-se adicionar uma lógica para criar o perfil aqui ou redirecionar para uma página de erro.
    return <div>Carregando perfil ou perfil não encontrado...</div>;
  }

  if (!allowedRoles.includes(profile.role)) {
    // Usuário autenticado, perfil carregado, mas papel não permitido
    // Redireciona para a página inicial ou uma página de acesso negado
    return <Navigate to="/" replace />; // Redireciona para a home page
  }

  // Se tudo estiver ok, renderiza os componentes filhos
  return children;
};

export default ProtectedRoute;
