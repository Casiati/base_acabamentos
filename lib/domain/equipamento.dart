class Equipamento {
  int? id;
  String? nome;
  double? valorDaCompra;
  double? valorAluguelDia;
  double? valorAluguelQuinzena;
  double? valorAluguelMes;

  Equipamento(
      {this.id,
        this.nome,
        this.valorDaCompra,
        this.valorAluguelDia,
        this.valorAluguelQuinzena,
        this.valorAluguelMes});

  Equipamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    valorDaCompra = json['valorDaCompra'];
    valorAluguelDia = json['valorAluguelDia'];
    valorAluguelQuinzena = json['valorAluguelQuinzena'];
    valorAluguelMes = json['valorAluguelMes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['valorDaCompra'] = this.valorDaCompra;
    data['valorAluguelDia'] = this.valorAluguelDia;
    data['valorAluguelQuinzena'] = this.valorAluguelQuinzena;
    data['valorAluguelMes'] = this.valorAluguelMes;
    return data;
  }
}
