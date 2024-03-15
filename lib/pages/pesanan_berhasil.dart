import 'package:flutter/material.dart';
import 'package:tratour_application/components/widgets/sukses_widget.dart';

class PesananBerhasil extends StatelessWidget {
  const PesananBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return SuksesPage(label: "Pesanan kamu berhasil");
  }
}
