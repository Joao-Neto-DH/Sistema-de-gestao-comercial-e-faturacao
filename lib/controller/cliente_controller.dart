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
}
