import 'package:express_inventory/cubit/barang/barang_cubit.dart';
import 'package:express_inventory/cubit/barang_keluar/barang_keluar_cubit.dart';
import 'package:express_inventory/cubit/barang_masuk/barang_masuk_cubit.dart';
import 'package:express_inventory/screens/barang/input_barang_screen.dart';
import 'package:express_inventory/screens/barang/update_barang_screen.dart';
import 'package:express_inventory/screens/barang_keluar/input_barang_keluar_screen.dart';
import 'package:express_inventory/screens/barang_masuk/input_barang_masuk_screen.dart';
import 'package:express_inventory/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/splash_screen.dart';
import 'screens/barang/barang_screen.dart';
import 'screens/barang_masuk/barang_masuk_screen.dart';
import 'screens/barang_keluar/barang_keluar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BarangCubit()),
        BlocProvider(create: (context) => BarangMasukCubit()),
        BlocProvider(create: (context) => BarangKeluarCubit()),
      ],
      child: MaterialApp(
        title: 'Inventory Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const MainScreen(),
          '/barang': (context) => const BarangScreen(),
          '/barang/add': (context) => const InputBarangScreen(),
          '/barang/update': (context) => const UpdateBarangScreen(),
          '/barang-masuk': (context) => const BarangMasukScreen(),
          '/barang-keluar': (context) => const BarangKeluarScreen(),
          '/input-barang-masuk': (context) => const InputBarangMasukScreen(),
          '/input-barang-keluar': (context) => const InputBarangKeluarScreen(),

        },
      ),
    );
  }
}