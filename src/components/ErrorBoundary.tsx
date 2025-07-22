// tuktuk-milfontes-gemini/src/components/ErrorBoundary.tsx
import React from "react";

interface ErrorBoundaryProps {
  children: React.ReactNode;
}

class ErrorBoundary extends React.Component<ErrorBoundaryProps> {
  state = { hasError: false };

  static getDerivedStateFromError() {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error("ErrorBoundary caught:", error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="p-4 text-center">
          <h1 className="text-xl font-bold text-red-600">Algo deu errado</h1>
          <p>Por favor, recarregue a página ou tente novamente mais tarde.</p>
        </div>
      );
    }
    return this.props.children;
  }
}

export default ErrorBoundary;