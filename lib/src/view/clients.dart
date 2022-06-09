import 'dart:math';

import 'package:bloc_test/src/bloc/client_bloc.dart';
import 'package:bloc_test/src/bloc/client_state.dart';
import 'package:flutter/material.dart';

import '../bloc/client_events.dart';
import '../model/client.dart';

class Clients extends StatefulWidget {
  const Clients({Key? key}) : super(key: key);

  @override
  State<Clients> createState() => _ClientsState();
}

String randomName() {
  final rand = Random();
  return [
    'Neymar Junior',
    'Thiago Silva',
    'Vinicius Junior',
    'Casemiro',
    'Paquetá',
    'Gabriel Jesus',
    'Hernanes',
    'Raphinha',
    'Richarlison',
    'Philippe Coutinho',
    'Firmino',
    'Rodrygo'
  ].elementAt(rand.nextInt(4));
}

class _ClientsState extends State<Clients> {
  @override
  initState() {
    super.initState();
    _clientBloc = ClientBloc();
    _clientBloc.inputClientEvent.add(LoadClientEvent());
  }

  //final List<Client> clientList = [];
  late final ClientBloc _clientBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pessoal do Hexa"),
        actions: [
          IconButton(
              onPressed: () {
                _clientBloc.inputClientEvent
                    .add(AddClientEvent(client: Client(name: randomName())));
              },
              icon: const Icon(Icons.person_add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: StreamBuilder<ClientState>(
            stream: _clientBloc.outputClientState,
            builder: (context, AsyncSnapshot<ClientState> snapshot) {
              List<Client> clientList = snapshot.data?.clients ?? [];
              return ListView.separated(
                itemCount: clientList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(clientList[index].name.toString()),
                    subtitle: const Text("Telefone: (62) 99181-7731"),
                    leading: CircleAvatar(
                      child: Text(clientList[index].name.toString()[0]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        _clientBloc.inputClientEvent
                            .add(RemoveClientEvent(client: clientList[index]));
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              );
            }),
      ),
    );
  }
}
