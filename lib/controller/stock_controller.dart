import '../dao/produto_dao.dart';

class StockController {
  final dao = ProdutoDAO();

  Future<List<Map<String, Object?>>> produto(String nomeOrId) async {
    final res = await dao.getProdutoByNomeOrId(nomeOrId);
    return res;
  }
}
