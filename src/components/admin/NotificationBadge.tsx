import React from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Bell,
  Check,
  CheckCheck,
  FileText,
  Clock,
  AlertCircle,
} from "lucide-react";
import { useAdminNotifications } from "@/hooks/useAdminNotifications";
import { format } from "date-fns";
import { pt } from "date-fns/locale";

interface NotificationBadgeProps {
  region?: string;
  className?: string;
}

export const NotificationBadge: React.FC<NotificationBadgeProps> = ({
  region,
  className = "",
}) => {
  const {
    notifications,
    unreadCount,
    isLoading,
    hasUnreadNotifications,
    markAsRead,
    markAllAsRead,
    isMarkingAsRead,
    isMarkingAllAsRead,
  } = useAdminNotifications({ region });

  const getNotificationIcon = (type: string) => {
    switch (type) {
      case "nova_candidatura":
        return <FileText className="h-4 w-4 text-blue-600" />;
      case "candidatura_aprovada":
        return <Check className="h-4 w-4 text-green-600" />;
      case "candidatura_rejeitada":
        return <AlertCircle className="h-4 w-4 text-red-600" />;
      default:
        return <Bell className="h-4 w-4 text-gray-600" />;
    }
  };

  if (isLoading) {
    return (
      <Button variant="ghost" size="sm" className={className} disabled>
        <Bell className="h-5 w-5" />
      </Button>
    );
  }

  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button variant="ghost" size="sm" className={`relative ${className}`}>
          <Bell className="h-5 w-5" />
          {hasUnreadNotifications && (
            <Badge
              variant="destructive"
              className="absolute -top-1 -right-1 h-5 w-5 rounded-full p-0 text-xs"
            >
              {unreadCount > 99 ? "99+" : unreadCount}
            </Badge>
          )}
        </Button>
      </PopoverTrigger>

      <PopoverContent className="w-80 p-0" align="end">
        <div className="border-b border-gray-200 p-4">
          <div className="flex items-center justify-between">
            <h3 className="font-semibold text-gray-900">Notificações</h3>
            {hasUnreadNotifications && (
              <Button
                variant="ghost"
                size="sm"
                onClick={() => markAllAsRead()}
                disabled={isMarkingAllAsRead}
                className="text-xs"
              >
                <CheckCheck className="h-4 w-4 mr-1" />
                Marcar todas como lidas
              </Button>
            )}
          </div>
          {hasUnreadNotifications && (
            <p className="text-sm text-gray-600 mt-1">
              {unreadCount}{" "}
              {unreadCount === 1 ? "nova notificação" : "novas notificações"}
            </p>
          )}
        </div>

        <ScrollArea className="h-[300px]">
          {notifications.length === 0 ? (
            <div className="p-4 text-center">
              <Bell className="h-8 w-8 text-gray-400 mx-auto mb-2" />
              <p className="text-sm text-gray-600">Nenhuma notificação</p>
            </div>
          ) : (
            <div className="space-y-1">
              {notifications.map((notification) => (
                <div
                  key={notification.id}
                  className={`p-3 border-b border-gray-100 hover:bg-gray-50 transition-colors ${
                    !notification.read ? "bg-blue-50" : ""
                  }`}
                >
                  <div className="flex items-start gap-3">
                    <div className="flex-shrink-0 mt-1">
                      {getNotificationIcon(notification.type)}
                    </div>

                    <div className="flex-1 min-w-0">
                      <h4 className="text-sm font-medium text-gray-900 truncate">
                        {notification.title}
                      </h4>
                      <p className="text-sm text-gray-600 mt-1 line-clamp-2">
                        {notification.message}
                      </p>

                      <div className="flex items-center justify-between mt-2">
                        <div className="flex items-center gap-1 text-xs text-gray-500">
                          <Clock className="h-3 w-3" />
                          {format(
                            new Date(notification.created_at),
                            "dd/MM HH:mm",
                            { locale: pt }
                          )}
                        </div>

                        {!notification.read && (
                          <Button
                            variant="ghost"
                            size="sm"
                            onClick={() =>
                              markAsRead(notification.application_id)
                            }
                            disabled={isMarkingAsRead}
                            className="text-xs h-6 px-2"
                          >
                            <Check className="h-3 w-3 mr-1" />
                            Marcar como lida
                          </Button>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </ScrollArea>

        {hasUnreadNotifications && (
          <div className="border-t border-gray-200 p-2">
            <Button
              variant="ghost"
              size="sm"
              className="w-full text-xs"
              onClick={() => {
                // Navegar para a aba de candidaturas
                // Esta funcionalidade dependeria do sistema de navegação
                console.log("Navegar para candidaturas");
              }}
            >
              Ver todas as candidaturas
            </Button>
          </div>
        )}
      </PopoverContent>
    </Popover>
  );
};

export default NotificationBadge;
