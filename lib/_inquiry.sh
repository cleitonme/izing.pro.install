#!/bin/bash

get_frontend_url() {
  print_banner
  printf "${WHITE} 💻 Digite o domínio da interface web (Frontend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  print_banner
  printf "${WHITE} 💻 Digite o domínio da sua API (Backend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_url
}

get_usuario() {
  print_banner
  printf "${WHITE} 💻 Adquira seu acesso pelo whatsapp (48) 99941-6725${GRAY_LIGHT}"
  printf "\n\n"
  printf "${WHITE} 💻 Digite o nome de usuario recebido na compra:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " username_down
}

get_senha() {
  print_banner
  printf "${WHITE} 💻 Adquira seu acesso pelo whatsapp (48) 99941-6725${GRAY_LIGHT}"
  printf "\n\n"
  printf "${WHITE} 💻 Digite a senha recebida na compra:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " senha_down
}

get_urls() {
  get_frontend_url
  get_backend_url
  get_usuario
  get_senha
}

software_update() {
  
  get_usuario
  get_senha
  verificar_senha
  system_pm2_stop
  system_update_izing
  frontend_node_dependencies
  frontend_node_build
  backend_node_dependencies
  backend_db_migrate
  backend_db_seed
  system_pm2_start
  script_adicionais
  system_success2
}

ativar_firewall () {
  iniciar_firewall
}

desativar_firewall () {
  parar_firewall
}

erro_qrcode () {
  system_pm2_stop
  backend_limpa_wwebjs_auth
  system_pm2_start
  system_successqrcode
}

Erro_global () {
  erro_banco
}

inquiry_options() {

  rm versao.json
  wget -q https://a.infomeurer.com.br/nova.json versao.json
  print_banner
  
# Verifica se o arquivo package.json existe
if [ -f "/home/deploy/izing.io/frontend/package.json" ]; then
  # Obtém a versão do package.json
  PACKAGE_VERSION=$(cat /home/deploy/izing.io/frontend/package.json | grep -oE '"version": "[0-9.]+"' | grep -oE '[0-9.]+')

  # Obtém a versão do arquivo de texto remoto
  REMOTE_VERSION=$(cat versao.json | grep -oE '"version": "[0-9.]+"' | grep -oE '[0-9.]+')

  # Compara as versões
  if [ "$PACKAGE_VERSION" == "$REMOTE_VERSION" ]; then
    echo -e "\033[0;32m✅ Versão atualizada.\033[0m"
  else
    echo -e "\033[0;31m❌ Versão desatualizada. Execute a atualização (opção 2) após fazer um snapshot da VPS.\033[0m"
  fi
else
  echo -e "\033[0;31m❌ Izing ainda não instalado.\033[0m"
fi


# Verifica se o UFW está ativado
if ! command -v ufw &> /dev/null; then
  echo -e "\033[0;31m❌ Servidor inseguro! O firewall está desativado.\033[0m"
fi
if sudo ufw status | grep -q "Status: inactive"; then
  echo -e "\033[0;31m❌ Servidor inseguro! O firewall está desativado.\033[0m"
fi
  printf "\n\n"
  printf "${WHITE} 💻 O que você precisa fazer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [1] Instalar\n"
  printf "   [2] Atualizar Izing(antes de atualizar faça um Snapshots da VPS\n"
  printf "   [3] Ativar Firewall\n"
  printf "   [4] Desativar Firewall\n"
  printf "   [5] Erro QRCODE - Atenção vai ter conectar conexões novamente\n"
  printf "   [6] Erro global/pg_filenode.map\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    1) get_urls ;;


    2) 
      software_update 
      exit
      ;;


    3) 
      ativar_firewall 
      exit
      ;;
	  
    4) 
      desativar_firewall 
      exit
      ;;
	
    5) 
      erro_qrcode
      exit
      ;;
	  
    6) 
      Erro_global 
      exit
      ;;

    *) exit ;;
  esac
}

