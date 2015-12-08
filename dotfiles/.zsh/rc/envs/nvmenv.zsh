# nvm
NVM_HOME=${HOME}/.nvm
if [ -e "${NVM_HOME}" ]; then
  source ${NVM_HOME}/nvm.sh
  nvm use stable
fi

