// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../model/client.dart';

abstract class ClientState {
  List<Client> clients;
  ClientState({
    required this.clients,
  });
}

class ClientInitialState extends ClientState {
  ClientInitialState() : super(clients: []);
}

class ClientSucessState extends ClientState {
  ClientSucessState({required List<Client> clients}) : super(clients: clients);
}
