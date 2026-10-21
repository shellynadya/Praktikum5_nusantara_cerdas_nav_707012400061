
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/app_routes.dart';
import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(
          create: (_) => FavoritCubit(),
        ),
        BlocProvider<PengajuanCubit>(
          create: (_) => PengajuanCubit(),
        ),
      ],
      child: const NusantaraCerdas(),
    ),
  );
}

class NusantaraCerdas extends StatelessWidget {
  const NusantaraCerdas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas Mobile',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      initialRoute: AppRoutes.beranda,
      routes: AppRoutes.daftarRoute(),
      onGenerateRoute: AppRoutes.bentukRoute,
      onUnknownRoute: AppRoutes.routeTidakDikenal,
    );
  }
}
