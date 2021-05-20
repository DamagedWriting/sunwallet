import 'package:flutter/material.dart';
import 'package:graft_wallet/generated/l10n.dart';
import 'package:graft_wallet/routes.dart';
import 'package:graft_wallet/src/stores/balance/balance_store.dart';
import 'package:graft_wallet/src/stores/wallet/wallet_store.dart';
import 'package:graft_wallet/src/widgets/graft_dialog.dart';
import 'package:provider/provider.dart';

class WalletMenu {
  WalletMenu(this.context);

  final List<String> items = [
    S.current.reconnect,
    S.current.rescan,
    S.current.reload_fiat
  ];

  final BuildContext context;

  void action(int index) {
    switch (index) {
      case 0:
        _presentReconnectAlert(context);
        break;
      case 1:
        Navigator.of(context).pushNamed(Routes.rescan);
        break;
      case 2:
        context.read<BalanceStore>().updateFiatBalance();
        break;
    }
  }

  Future<void> _presentReconnectAlert(BuildContext context) async {
    final walletStore = context.read<WalletStore>();

    await showSimplegraftDialog(
        context, S.of(context).reconnection, S.of(context).reconnect_alert_text,
        onPressed: (context) {
      walletStore.reconnect();
      Navigator.of(context).pop();
    });
  }
}
