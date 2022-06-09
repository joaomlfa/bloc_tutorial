import 'dart:async';

import 'package:bloc_test/src/bloc/client_events.dart';
import 'package:bloc_test/src/bloc/client_state.dart';

import '../model/client.dart';
import '../repositories/clientsRepository.dart';

class ClientBloc {
  final _repositoryClient = ClientsRepository();

  final StreamController<ClientEvent> _inputClientEventController =
      StreamController<ClientEvent>();
  final StreamController<ClientState> _outputClientStateController =
      StreamController<ClientState>();

  Sink<ClientEvent> get inputClientEvent => _inputClientEventController.sink;

  Stream<ClientState> get outputClientState =>
      _outputClientStateController.stream;

  ClientBloc() {
    _inputClientEventController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvent event) {
    List<Client> clients = [];
    if (event is LoadClientEvent) {
      clients = _repositoryClient.loadClients();
    } else if (event is AddClientEvent) {
      clients = _repositoryClient.addClient(event.client);
    } else if (event is RemoveClientEvent) {
      clients = _repositoryClient.removeClient(event.client);
    }
    _outputClientStateController.add(ClientSucessState(clients: clients));
  }
}
