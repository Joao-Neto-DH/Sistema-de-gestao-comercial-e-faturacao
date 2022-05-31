import '../dao/produto_dao.dart';
import '../model/produto_model.dart';

class ProdutoController {
  final _dao = ProdutoDAO();

  Future<int> cadastrarProduto(ProdutoModel produto) async {
    return await _dao.insert(produto);
    // print(await dao.all);
  }

  Future<List<ProdutoModel>> produto(String nomeOrId) async {
    final res = await _dao.getProdutoByNomeOrId(nomeOrId);
    final produtos = <ProdutoModel>[];
    for (var produto in res) {
      produtos.add(ProdutoModel.fromMap(produto));
    }
    return produtos;
  }

  Future<int> update(ProdutoModel produto) async {
    return await _dao.update(produto);
  }
}
