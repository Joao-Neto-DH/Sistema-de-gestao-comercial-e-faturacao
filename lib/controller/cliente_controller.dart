import '../dao/cliente_dao.dart';
import '../model/cliente_model.dart';

class ClienteController {
  final _dao = ClienteDAO();

  Future<int> cadastrarCliente(ClienteModel cliente) async {
    final res = await _dao.insert(cliente);
    // print(await dao.all);
    return res;
  }

  Future<List<ClienteModel>> getClienteByNomeOrId(String nomeOrID) async {
    final res = await _dao.cliente(nomeOrID);
    final clientes = <ClienteModel>[];
    // print(res);
    for (var cliente in res) {
      clientes.add(ClienteModel.fromMap(cliente));
    }
    return clientes;
  }

  Future<List<ClienteModel>> get all async {
    final res = await _dao.all;
    final clientes = <ClienteModel>[];
    for (var item in res) {
      clientes.add(ClienteModel.fromMap(item));
    }

    return clientes;
  }

  Future<int> delete(ClienteModel cliente) async {
    return await _dao.remove(cliente);
  }
}
