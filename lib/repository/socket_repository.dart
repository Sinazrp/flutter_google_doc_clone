import 'package:flutter_google_doc_clone/client/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepsitory {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  void joinRoom(String documentId) {
    _socketClient.connect();
    _socketClient
        .onConnect((data) => print('Connection established for : $documentId'));
    _socketClient
        .onConnectError((data) => print('connection error for : $data'));
    _socketClient
        .onDisconnect((data) => print('connection closed for : $documentId'));
    _socketClient.emit('join', documentId);
  }

  void typing(Map<String, dynamic> data) {
    _socketClient.emit('typing', data);
  }

  void changeListener(Function(Map<String, dynamic>) func) {
    _socketClient.on('changes', (data) => func(data));
  }

  void autoSave(Map<String, dynamic> data) {
    _socketClient.emit('save', data);
  }
}
