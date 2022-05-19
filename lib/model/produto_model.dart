class ProdutoModel {
  int? id;
  String nome;
  double preco;
  // String referencia;
  bool? iva;
  int stock;
  // DateTime? insercaoData;
  // DateTime? actualizacaoData;

  ProdutoModel({
    this.id,
    this.iva,
    // this.insercaoData,
    // this.actualizacaoData,
    required this.nome,
    required this.preco,
    // required this.referencia,
    required this.stock,
  });

  Map<String, Object?> get toMap {
    return {
      "id": id,
      "nome": nome,
      "preco": preco,
      "stock": stock,
      "iva": iva == true ? 1 : 0
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> produto) {
    return ProdutoModel(
      id: produto["id"],
      nome: produto["nome"],
      preco: produto["preco"],
      stock: produto["stock"],
      iva: produto["iva"] == 1 ? true : false,
    );
  }

  ProdutoModel copyWith({
    bool? iva,
    String? nome,
    double? preco,
    int? stock,
  }) {
    return ProdutoModel(
        id: id,
        iva: this.iva,
        nome: nome ?? this.nome,
        preco: preco ?? this.preco,
        stock: stock ?? this.stock);
  }

  @override
  bool operator ==(Object other) {
    return other is ProdutoModel &&
        other.id == id &&
        other.nome == nome &&
        other.preco == preco;
  }

  @override
  int get hashCode =>
      id.hashCode ^ nome.hashCode ^ preco.hashCode ^ iva.hashCode;
}
