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

  Future<List<ProdutoModel>> get all async {
    final lista = await _dao.all;
    final produtos = <ProdutoModel>[];
    for (var item in lista) {
      produtos.add(ProdutoModel.fromMap(item));
    }

    return produtos;
  }

  Future<int> delete(ProdutoModel produto) async {
    return await _dao.remove(produto);
  }
}
