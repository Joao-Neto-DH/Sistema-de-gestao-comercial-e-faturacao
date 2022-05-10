class ProdutoModel {
  int? id;
  String nome;
  double preco;
  String referencia;
  bool? iva;
  int stock;
  DateTime? insercaoData;
  DateTime? actualizacaoData;

  ProdutoModel({
    this.id,
    this.iva,
    this.insercaoData,
    this.actualizacaoData,
    required this.nome,
    required this.preco,
    required this.referencia,
    required this.stock,
  });
}
