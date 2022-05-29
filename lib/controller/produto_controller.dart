import '../dao/produto_dao.dart';
import '../model/produto_model.dart';

class ProdutoController {
  final dao = ProdutoDAO();

  Future<int> cadastrarProduto(ProdutoModel produto) async {
    return await dao.insert(produto);
    // print(await dao.all);
  }

  Future<List<ProdutoModel>> produto(String nomeOrId) async {
    final res = await dao.getProdutoByNomeOrId(nomeOrId);
    final produtos = <ProdutoModel>[];
    for (var produto in res) {
      produtos.add(ProdutoModel.fromMap(produto));
    }
    return produtos;
  }
}
