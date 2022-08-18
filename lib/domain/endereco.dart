class Endereco {
  int? id;
  String? cep;
  String? logradouro;
  String? numero;
  String? bairro;
  String? localidade;
  String? uf;

  Endereco({
    this.id,
    this.cep,
    this.logradouro,
    this.numero,
    this.bairro,
    this.localidade,
    this.uf,
  });

  Endereco.fromJson(Map<String, dynamic> json){
    id = json['id'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cep'] = cep;
    _data['logradouro'] = logradouro;
    _data['numero'] = numero;
    _data['bairro'] = bairro;
    _data['localidade'] = localidade;
    _data['uf'] = uf;
    return _data;
  }
}