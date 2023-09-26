import 'package:flutter_google_doc_clone/client/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepsitory {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  void joinRoom(String documentId) {
    _socketClient.emit('join', documentId);
  }
}
