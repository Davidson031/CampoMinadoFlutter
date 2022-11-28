import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:campo_minado/widgets/tabuleiro_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/resultado_widget.dart';
import 'package:campo_minado/widgets/campo_widget.dart';
import 'package:campo_minado/models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  Tabuleiro _getTabuleiro(double larguraTela, double alturaTela) {
    if (_tabuleiro == null) {
      int qtdDeColunas = 15;
      double tamanhoDoCampo = larguraTela / qtdDeColunas;
      int qtdDeLinhas = (alturaTela / tamanhoDoCampo).floor();

      _tabuleiro =
          Tabuleiro(linhas: qtdDeLinhas, colunas: qtdDeColunas, qtdBombas: 3);
    }
    return _tabuleiro!;
  }

  _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    setState(() {
      try {
        if (_venceu != null) {
          return;
        }
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro!.revelarBombas();
      }
    });
  }

  void _alternar(Campo campo) {
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(onReiniciar: _reiniciar, venceu: _venceu),
        body: Container(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return TabuleiroWidget(
                tabuleiro: _getTabuleiro(constraints.maxWidth, constraints.maxHeight),
                onAbrir: _abrir,
                onAlternarMarcacao: _alternar,
              );
            },
          ),
        ),
      ),
    );
  }
}
