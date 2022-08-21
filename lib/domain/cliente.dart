import 'endereco.dart';

class Cliente {
  int? id;
  String? nome;
  String? cpfCnpj;
  String? telefone1;
  String? telefone2;
  Endereco? endereco;

  Cliente({
    this.id,
    this.nome,
    this.cpfCnpj,
    this.telefone1,
    this.telefone2,
    this.endereco,
  });

  Cliente.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    nome = json['nome'] as String?;
    cpfCnpj = json['cpfCnpj'] as String?;
    telefone1 = json['telefone1'] as String?;
    telefone2 = json['telefone2'] as String?;
    endereco = (json['endereco'] as Map<String, dynamic>?) != null
        ? Endereco.fromJson(json['endereco'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['nome'] = nome;
    json['cpfCnpj'] = cpfCnpj;
    json['telefone1'] = telefone1;
    json['telefone2'] = telefone2;
    json['endereco'] = endereco?.toJson();
    return json;
  }
}


