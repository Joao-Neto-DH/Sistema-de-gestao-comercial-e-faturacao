import '../dao/produto_dao.dart';
import '../model/produto_model.dart';

class ProdutoController {
  final dao = ProdutoDAO();

  Future<void> cadastrarProduto(ProdutoModel produto) async {
    await dao.insert(produto);
    // print(await dao.all);
  }

  Future<List<Map<String, Object?>>> produto(String nomeOrId) async {
    final res = await dao.getProdutoByNomeOrId(nomeOrId);
    return res;
  }
}
