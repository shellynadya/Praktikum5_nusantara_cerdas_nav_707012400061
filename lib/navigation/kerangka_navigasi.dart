
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final layarLebar = lebar >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_indeksTerpilih]),
      ),
      drawer: _buatDrawer(),
      body: layarLebar
          ? _buatLayoutLebar()
          : _halaman[_indeksTerpilih],
      bottomNavigationBar:
          layarLebar ? null : _buatNavigationBar(),
    );
  }

  // Badge jumlah pengajuan menggunakan BlocSelector
  Widget _ikonWarga({
    required bool terpilih,
  }) {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (state) => state.length,
      builder: (context, jumlahPengajuan) {
        final ikon = Icon(
          terpilih ? Icons.person : Icons.person_outline,
        );

        if (jumlahPengajuan == 0) {
          return ikon;
        }

        return Badge(
          label: Text('$jumlahPengajuan'),
          child: ikon,
        );
      },
    );
  }

  // NavigationBar untuk layar sempit
  Widget _buatNavigationBar() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(
            Icons.miscellaneous_services_outlined,
          ),
          selectedIcon: Icon(
            Icons.miscellaneous_services,
          ),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _ikonWarga(terpilih: false),
          selectedIcon: _ikonWarga(terpilih: true),
          label: 'Warga',
        ),
      ],
    );
  }

  // NavigationRail untuk layar lebar
  Widget _buatLayoutLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          destinations: [
            const NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: Text('Beranda'),
            ),
            const NavigationRailDestination(
              icon: Icon(
                Icons.miscellaneous_services_outlined,
              ),
              selectedIcon: Icon(
                Icons.miscellaneous_services,
              ),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: _ikonWarga(terpilih: false),
              selectedIcon: _ikonWarga(terpilih: true),
              label: const Text('Warga'),
            ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _halaman[_indeksTerpilih],
        ),
      ],
    );
  }

  // NavigationDrawer tetap seperti Modul 2
  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (index) {
        _pilihTujuan(index);
        Navigator.pop(context);
      },
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Warga Nusantara'),
          accountEmail: Text('warga@nusantara.id'),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(
            Icons.miscellaneous_services_outlined,
          ),
          selectedIcon: Icon(
            Icons.miscellaneous_services,
          ),
          label: Text('Layanan'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Warga'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.pengaturan,
            );
          },
        ),
      ],
    );
  }
}
