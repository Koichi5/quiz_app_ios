import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<int> bottomNavBarSelectedIndexProvider =
    StateProvider((ref) => 0);

class BottomNavBar extends HookConsumerWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final Map<String, IconData> bottomContentList = {
    "ホーム": Icons.home,
    "復習": Icons.star,
    "追加": Icons.add,
    "設定": Icons.settings,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavBarSelectedIndex =
        ref.watch(bottomNavBarSelectedIndexProvider);
    final bottomNavBarSelectedIndexNotifier =
        ref.watch(bottomNavBarSelectedIndexProvider.notifier);

    return BottomNavyBar(
      items: _buildBottomNavyBarItems(context),
      selectedIndex: bottomNavBarSelectedIndex,
      onItemSelected: (index) {
        bottomNavBarSelectedIndexNotifier.state = index;
      },
    );
  }

  List<BottomNavyBarItem> _buildBottomNavyBarItems(BuildContext context) {
    return bottomContentList.entries.map((entry) {
      return BottomNavyBarItem(
        title: Text(entry.key),
        icon: Icon(entry.value),
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.inversePrimary,
      );
    }).toList();
  }
}
