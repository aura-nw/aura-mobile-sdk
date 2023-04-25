const List<String> evmRequest = [
  'eth_getEncryptionPublicKey',
  'eth_sign',
  'personal_sign',
  'personal_ecRecover',
  'sign_transaction',
  'eth_sendTransaction',
  'send_transaction',
  'eth_signTypedData',
  'eth_signTypedData_v3',
  'eth_signTypedData_v4',
  'eth_accounts',
  'eth_requestAccounts'
];

const List<String> solRequestType = [
'sol_accounts',
'sol_requestAccounts',
'sol_sign',
'sol_signAllTransactions',
'sol_signMessage',
'sol_verify',
'transfer'
];

const List<String> nearRequestType = [
'near_account',
'near_accountBalance',
'near_accountState',
'near_view',
'near_signAndSendTransaction'
];

const List<String> terraRequestType = ['connect', 'sign', 'post'];

const List<String> cosmosRequestType = [
'cosmos_getKey',
'cosmos_sign',
'cosmos_signAmino',
'cosmos_signDirect',
'cosmos_sendTx',
'cosmos_experimentalSuggestChain'
];