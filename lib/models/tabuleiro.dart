import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdBombas;
  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void _criarCampos() {
    //loop das linhas
    for (int l = 0; l < linhas; l++) {
      //loop colunas
      for (int c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void revelarBombas(){
    _campos.forEach((campo) => campo.revelarBomba());
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if(qtdBombas > linhas * colunas) { return; };

    while (sorteadas < qtdBombas) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  void reiniciar(){
    _campos.forEach((campo) => campo.reiniciar());
    _sortearMinas();
  }

  List<Campo> get campos { 
    return _campos;
  }

  bool get resolvido { 
    return _campos.every((campo) => campo.resolvido);
  }
}
