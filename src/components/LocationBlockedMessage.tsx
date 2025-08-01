import React from "react";

function getUserEnvironment() {
  const ua = navigator.userAgent.toLowerCase();
  const os = /android/.test(ua)
    ? "android"
    : /iphone|ipad|ipod/.test(ua)
    ? "ios"
    : /windows/.test(ua)
    ? "windows"
    : /macintosh/.test(ua)
    ? "mac"
    : "other";
  const browser = /crios|chrome/.test(ua)
    ? "chrome"
    : /safari/.test(ua) && !/chrome/.test(ua)
    ? "safari"
    : /firefox/.test(ua)
    ? "firefox"
    : /edg/.test(ua)
    ? "edge"
    : "other";
  return { os, browser };
}

const LocationBlockedMessage: React.FC = () => {
  const { os, browser } = getUserEnvironment();
  let instructions;

  if (os === "android" && browser === "chrome") {
    instructions = (
      <>
        <img src="/assets/site-settings-icon.png" alt="Configurações do site" style={{ width: 24, height: 24, verticalAlign: "middle", marginRight: 4 }} /> <strong>Permissão de Localização Bloqueada</strong><br />
        <br />Para ativares a localização:<br />
        <img src="/assets/site-settings-icon.png" alt="Configurações do site" style={{ width: 20, height: 20, verticalAlign: "middle", marginRight: 4 }} /> Toca no ícone de <strong>configurações do site</strong> ao lado do endereço do site<br />
        ⚙️ Seleciona <strong>Permissões</strong><br />
        ✅ Ativa <strong>"Localização"</strong><br />
        <br />🧭 <em>Depois de ativares, volta ao site e tenta novamente.</em>
      </>
    );
  } else if (os === "ios" && browser === "safari") {
    instructions = (
      <>
        📲 <strong>Permissão de Localização Bloqueada</strong><br />
        <br />Para ativares a localização:<br />
        📲 Toca no ícone <strong>“AA”</strong> no canto esquerdo da barra de endereços<br />
        ⚙️ Vai a <strong>Ajustes &gt; Safari &gt; Localização</strong><br />
        ✅ Ativa <strong>"Localização"</strong><br />
        <br />🧭 <em>Depois de ativares, volta ao site e tenta novamente.</em>
      </>
    );
  } else if (os === "ios" && browser === "chrome") {
    instructions = (
      <>
        ⚙️ <strong>Permissão de Localização Bloqueada</strong><br />
        <br />Para ativares a localização:<br />
        ⚙️ Abre o app <strong>“Ajustes”</strong> do iOS<br />
        🔍 Pesquisa por <strong>“Chrome”</strong><br />
        ✅ Ativa <strong>"Localização"</strong><br />
        <br />🧭 <em>Depois de ativares, volta ao site e tenta novamente.</em>
      </>
    );
  } else if (os === "android" && browser === "firefox") {
    instructions = (
      <>
        🔒 <strong>Permissão de Localização Bloqueada</strong><br />
        <br />Para ativares a localização:<br />
        🔒 Toca no ícone de <strong>cadeado</strong> ao lado do endereço do site<br />
        ⚙️ Seleciona <strong>Permissões</strong><br />
        ✅ Ativa <strong>"Localização"</strong><br />
        <br />🧭 <em>Depois de ativares, volta ao site e tenta novamente.</em>
      </>
    );
  } else {
    instructions = (
      <>
        🌐 <strong>Permissão de Localização Bloqueada</strong><br />
        <br />Para ativares a localização:<br />
        🌐 Toca no ícone perto do endereço (cadeado ou globo)<br />
        ⚙️ Seleciona <strong>Permissões ou Configurações</strong><br />
        ✅ Ativa <strong>"Localização"</strong><br />
        <br />🧭 <em>Depois de ativares, volta ao site e tenta novamente.</em>
      </>
    );
  }

  return (
    <div className="fixed bottom-4 right-4 bg-yellow-100 p-4 rounded shadow-lg max-w-sm z-50 text-base">
      {instructions}
      <p className="mt-2 text-sm text-gray-600">
        Se preferires, podes navegar manualmente no mapa sem localização.
      </p>
    </div>
  );
};

export default LocationBlockedMessage;
