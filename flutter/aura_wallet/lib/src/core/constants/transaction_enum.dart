// ignore_for_file: constant_identifier_names

const TYPE_TRANSACTION_MAP = {
  TransactionType.IBCTransfer: TransactionTypeValue.IBCTransfer,
  TransactionType.IBCReceived: TransactionTypeValue.IBCReceived,
  TransactionType.IBCAcknowledgement: TransactionTypeValue.IBCAcknowledgement,
  TransactionType.IBCUpdateClient: TransactionTypeValue.IBCUpdateClient,
  TransactionType.IBCTimeout: TransactionTypeValue.IBCTimeout,
  TransactionType.IBCChannelOpenInit: TransactionTypeValue.IBCChannelOpenInit,
  TransactionType.IBCConnectionOpenInit:
      TransactionTypeValue.IBCConnectionOpenInit,
  TransactionType.IBCCreateClient: TransactionTypeValue.IBCCreateClient,
  TransactionType.IBCChannelOpenAck: TransactionTypeValue.IBCChannelOpenAck,
  TransactionType.Send: TransactionTypeValue.Send,
  TransactionType.MultiSend: TransactionTypeValue.MultiSend,
  TransactionType.Delegate: TransactionTypeValue.Delegate,
  TransactionType.Undelegate: TransactionTypeValue.Undelegate,
  TransactionType.Redelegate: TransactionTypeValue.Redelegate,
  TransactionType.GetReward: TransactionTypeValue.GetReward,
  TransactionType.SwapWithinBatch: TransactionTypeValue.SwapWithinBatch,
  TransactionType.DepositWithinBatch: TransactionTypeValue.DepositWithinBatch,
  TransactionType.EditValidator: TransactionTypeValue.EditValidator,
  TransactionType.CreateValidator: TransactionTypeValue.CreateValidator,
  TransactionType.Unjail: TransactionTypeValue.Unjail,
  TransactionType.StoreCode: TransactionTypeValue.StoreCode,
  TransactionType.InstantiateContract: TransactionTypeValue.InstantiateContract,
  TransactionType.ExecuteContract: TransactionTypeValue.ExecuteContract,
  TransactionType.ModifyWithdrawAddress:
      TransactionTypeValue.ModifyWithdrawAddress,
  TransactionType.JoinPool: TransactionTypeValue.JoinPool,
  TransactionType.LockTokens: TransactionTypeValue.LockTokens,
  TransactionType.JoinSwapExternAmountIn:
      TransactionTypeValue.JoinSwapExternAmountIn,
  TransactionType.SwapExactAmountIn: TransactionTypeValue.SwapExactAmountIn,
  TransactionType.BeginUnlocking: TransactionTypeValue.BeginUnlocking,
  TransactionType.Vote: TransactionTypeValue.Vote,
  TransactionType.Vesting: TransactionTypeValue.Vesting,
  TransactionType.Deposit: TransactionTypeValue.Deposit,
  TransactionType.SubmitProposalTx: TransactionTypeValue.SubmitProposalTx,
  TransactionType.GetRewardCommission: TransactionTypeValue.GetRewardCommission,
  TransactionType.PeriodicVestingAccount:
      TransactionTypeValue.PeriodicVestingAccount,
  TransactionType.BasicAllowance: TransactionTypeValue.BasicAllowance,
  TransactionType.PeriodicAllowance: TransactionTypeValue.PeriodicAllowance,
  TransactionType.MsgGrantAllowance: TransactionTypeValue.MsgGrantAllowance,
  TransactionType.MsgRevokeAllowance: TransactionTypeValue.MsgRevokeAllowance,
  TransactionType.GrantAuthz: TransactionTypeValue.GrantAuthz,
  TransactionType.ExecuteAuthz: TransactionTypeValue.ExecuteAuthz,
  TransactionType.RevokeAuthz: TransactionTypeValue.RevokeAuthz,
  TransactionType.Fail: TransactionTypeValue.Fail,
};

class TransactionTypeValue {
  static const String IBCTransfer = 'IBC Transfer';
  static const String IBCReceived = 'IBC Received';
  static const String IBCAcknowledgement = 'IBC Acknowledgement';
  static const String IBCUpdateClient = 'IBC Update Client';
  static const String IBCTimeout = 'IBC Timeout';
  static const String IBCChannelOpenInit = 'IBC Channel Open Init';
  static const String IBCConnectionOpenInit = 'IBC Connect Open Init';
  static const String IBCCreateClient = 'IBC Create Client';
  static const String IBCChannelOpenAck = 'IBC Channel Open Ack';
  static const String Send = 'Send';
  static const String Received = 'Receive';
  static const String MultiSend = 'Multi Send';
  static const String Delegate = 'Delegate';
  static const String Undelegate = 'Undelegate';
  static const String Redelegate = 'Redelegate';
  static const String GetReward = 'Get Reward';
  static const String SwapWithinBatch = 'Swap Within Batch';
  static const String DepositWithinBatch = 'Deposit Within Batch';
  static const String EditValidator = 'Edit Validator';
  static const String CreateValidator = 'Create Validator';
  static const String Unjail = 'Unjail';
  static const String StoreCode = 'Store Code';
  static const String InstantiateContract = 'Instantiate Contract';
  static const String ExecuteContract = 'Execute Contract';
  static const String ModifyWithdrawAddress = 'Modify Withdraw Address';
  static const String JoinPool = 'Join pool';
  static const String LockTokens = 'Lock Tokens (Start Farming)';
  static const String JoinSwapExternAmountIn = 'Join Swap Extern Amount In';
  static const String SwapExactAmountIn = 'Swap Exact Amount In';
  static const String BeginUnlocking = 'Begin Unlocking';
  static const String Vote = 'Vote';
  static const String Vesting = 'Vesting';
  static const String Deposit = 'Deposit';
  static const String SubmitProposalTx = 'Submit Proposal';
  static const String GetRewardCommission = 'Get Reward Commission';
  static const String PeriodicVestingAccount = 'Periodic Vesting';
  static const String BasicAllowance = 'Basic';
  static const String PeriodicAllowance = 'Periodic';
  static const String MsgGrantAllowance = 'Grant Allowance';
  static const String MsgRevokeAllowance = 'Revoke Allowance';
  static const String GrantAuthz = 'Grant Authz';
  static const String ExecuteAuthz = 'Execute Authz';
  static const String RevokeAuthz = 'Revoke Authz';
  static const String Fail = 'Fail';
}

class TransactionType {
  static const String IBCTransfer = '/ibc.applications.transfer.v1.MsgTransfer';
  static const String IBCReceived = '/ibc.core.channel.v1.MsgRecvPacket';
  static const String IBCAcknowledgement =
      '/ibc.core.channel.v1.MsgAcknowledgement';
  static const String IBCUpdateClient = '/ibc.core.client.v1.MsgUpdateClient';
  static const String IBCTimeout = '/ibc.core.channel.v1.MsgTimeout';
  static const String IBCChannelOpenInit =
      '/ibc.core.channel.v1.MsgChannelOpenInit';
  static const String IBCConnectionOpenInit =
      '/ibc.core.connection.v1.MsgConnectionOpenInit';
  static const String IBCCreateClient = '/ibc.core.client.v1.MsgCreateClient';
  static const String IBCChannelOpenAck =
      '/ibc.core.channel.v1.MsgChannelOpenAck';
  static const String Send = '/cosmos.bank.v1beta1.MsgSend';
  static const String MultiSend = '/cosmos.bank.v1beta1.MsgMultiSend';
  static const String Delegate = '/cosmos.staking.v1beta1.MsgDelegate';
  static const String Undelegate = '/cosmos.staking.v1beta1.MsgUndelegate';
  static const String Redelegate = '/cosmos.staking.v1beta1.MsgBeginRedelegate';
  static const String GetReward =
      '/cosmos.distribution.v1beta1.MsgWithdrawDelegatorReward';
  static const String SwapWithinBatch =
      '/tendermint.liquidity.v1beta1.MsgSwapWithinBatch';
  static const String DepositWithinBatch =
      '/tendermint.liquidity.v1beta1.MsgDepositWithinBatch';
  static const String EditValidator =
      '/cosmos.staking.v1beta1.MsgEditValidator';
  static const String CreateValidator =
      '/cosmos.staking.v1beta1.MsgCreateValidator';
  static const String Unjail = '/cosmos.slashing.v1beta1.MsgUnjail';
  static const String StoreCode = '/cosmwasm.wasm.v1.MsgStoreCode';
  static const String InstantiateContract =
      '/cosmwasm.wasm.v1.MsgInstantiateContract';
  static const String ExecuteContract = '/cosmwasm.wasm.v1.MsgExecuteContract';
  static const String ModifyWithdrawAddress =
      '/cosmos.distribution.v1beta1.MsgSetWithdrawAddress';
  static const String JoinPool = '/osmosis.gamm.v1beta1.MsgJoinPool';
  static const String LockTokens = '/osmosis.lockup.MsgLockTokens';
  static const String JoinSwapExternAmountIn =
      '/osmosis.gamm.v1beta1.MsgJoinSwapExternAmountIn';
  static const String SwapExactAmountIn =
      '/osmosis.gamm.v1beta1.MsgSwapExactAmountIn';
  static const String BeginUnlocking = '/osmosis.lockup.MsgBeginUnlocking';
  static const String Vote = '/cosmos.gov.v1beta1.MsgVote';
  static const String Vesting =
      '/cosmos.vesting.v1beta1.MsgCreateVestingAccount';
  static const String Deposit = '/cosmos.gov.v1beta1.MsgDeposit';
  static const String SubmitProposalTx =
      '/cosmos.gov.v1beta1.MsgSubmitProposal';
  static const String GetRewardCommission =
      '/cosmos.distribution.v1beta1.MsgWithdrawValidatorCommission';
  static const String PeriodicVestingAccount =
      '/cosmos.vesting.v1beta1.MsgCreatePeriodicVestingAccount';
  static const String BasicAllowance =
      '/cosmos.feegrant.v1beta1.BasicAllowance';
  static const String PeriodicAllowance =
      '/cosmos.feegrant.v1beta1.PeriodicAllowance';
  static const String MsgGrantAllowance =
      '/cosmos.feegrant.v1beta1.MsgGrantAllowance';
  static const String MsgRevokeAllowance =
      '/cosmos.feegrant.v1beta1.MsgRevokeAllowance';
  static const String AllowedMsgAllowance =
      '/cosmos.feegrant.v1beta1.AllowedMsgAllowance';
  static const String AllowedContractAllowance =
      '/cosmos.feegrant.v1beta1.AllowedContractAllowance';
  static const String GrantAuthz = '/cosmos.authz.v1beta1.MsgGrant';
  static const String ExecuteAuthz = '/cosmos.authz.v1beta1.MsgExec';
  static const String RevokeAuthz = '/cosmos.authz.v1beta1.MsgRevoke';
  static const String Fail = 'FAILED';
}
