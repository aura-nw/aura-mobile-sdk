import 'package:aura_wallet/src/presentation/screens/home/setting/setting_screen.dart';
import 'package:aura_wallet/src/presentation/screens/home/wallet/wallet_screen.dart';
import 'package:aura_wallet/src/presentation/screens/home/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              ignoring: index !=0,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 1,
                ),
                opacity: index == 0 ? 1 : 0,
                child: const WalletScreen(),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: index != 1,
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 1,
                ),
                opacity: index == 1 ? 1 : 0,
                child: const SettingScreen(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        onChange: (index) {
          if (this.index != index) {
            setState(() {
              this.index = index;
            });
          }
        },
        index: index,
      ),
    );
  }
}
