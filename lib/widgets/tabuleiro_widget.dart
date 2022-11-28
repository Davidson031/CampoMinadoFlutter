import 'package:campo_minado/widgets/campo_widget.dart';
import 'package:flutter/material.dart';
import '../models/campo.dart';
import '../models/tabuleiro.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  TabuleiroWidget(
      {required this.tabuleiro,
      required this.onAbrir,
      required this.onAlternarMarcacao});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: tabuleiro.colunas,
        children: tabuleiro.campos.map((campo) {
          return CampoWidget(
            campo: campo,
            onAbrir: onAbrir,
            onAlternarMarcacao: onAlternarMarcacao,
          );
        }).toList(),
      ),
    );
  }
}
