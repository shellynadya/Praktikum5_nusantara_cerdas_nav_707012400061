
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final String nama;
  final String dinas;
  final String jam;
  final String keterangan;

  const HalamanDetailLayanan({
    super.key,
    required this.nama,
    required this.dinas,
    required this.jam,
    required this.keterangan,
  });

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool sedangMengirim = false;

  Future<void> ajukanPermohonan() async {
    if (sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    context
        .read<PengajuanCubit>()
        .tambahPengajuan(widget.nama);

    setState(() {
      sedangMengirim = false;
    });

    Navigator.pop(
      context,
      'Permohonan ${widget.nama} telah diajukan',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              size: 70,
              color: Colors.indigo,
            ),
            const SizedBox(height: 20),
            Text(
              widget.nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Dinas Penanggung Jawab',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(widget.dinas),
            const SizedBox(height: 15),
            const Text(
              'Jam Operasional',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(widget.jam),
            const SizedBox(height: 15),
            const Text(
              'Keterangan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(widget.keterangan),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: sedangMengirim
                    ? null
                    : ajukanPermohonan,
                icon: sedangMengirim
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  sedangMengirim
                      ? 'Mengirim...'
                      : 'Ajukan Permohonan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
