import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  group('Teste Campo', (){

    test('Abrir campo COM explosão', (){
      Campo c = Campo(linha: 0, coluna: 0);
      c.minar();

      expect(c.abrir, throwsException);
    });

    test('Abrir campo SEM explosão', (){
      Campo c = Campo(linha: 0, coluna: 0);
      c.abrir();

      expect(c.aberto, true);
    });

    test('Adicionar NÃO vizinho', (){
      Campo c1 = Campo(linha: 0, coluna: 0);
      Campo c2 = Campo(linha: 1, coluna: 3);

      c1.adicionarVizinho(c2);

      expect(c1.vizinhos.isEmpty, true);
    });

    test('Adicionar Vizinho', (){
      Campo c1 = Campo(linha: 0, coluna: 0);
      Campo c2 = Campo(linha: 0, coluna: 1);

      c1.adicionarVizinho(c2);
      expect(c1.vizinhos.contains(c2), true);
    });

  });
}