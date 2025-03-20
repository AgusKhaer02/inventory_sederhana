import 'package:express_inventory/screens/barang_keluar/barang_keluar_screen.dart';
import 'package:express_inventory/screens/barang_masuk/barang_masuk_screen.dart';
import 'package:express_inventory/screens/barang/barang_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> viewTabs = [
    BarangScreen(),
    BarangMasukScreen(),
    BarangKeluarScreen(),
  ];

  List<Tab> tabs = [
    Tab(icon: Icon(Icons.inventory),),
    Tab(icon: Icon(Icons.arrow_downward),),
    Tab(icon: Icon(Icons.arrow_upward),),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: TabBarView(children: viewTabs),
        bottomNavigationBar: TabBar(tabs: tabs),
      ),
    );
  }
}
