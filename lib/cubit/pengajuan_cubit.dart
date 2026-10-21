
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(<String>[]);

  void tambahPengajuan(String namaLayanan) {
    emit([...state, namaLayanan]);
  }

  void hapusPengajuan(String namaLayanan) {
    final daftarBaru = List<String>.from(state);
    daftarBaru.remove(namaLayanan);
    emit(daftarBaru);
  }

  void kosongkanPengajuan() {
    emit(<String>[]);
  }

  int get totalPengajuan => state.length;
}
