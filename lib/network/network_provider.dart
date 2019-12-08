

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'message.dart';

class NetworkAdapter {

  static NetworkAdapter _instance;

  RawDatagramSocket _datagramSocket;
  ServerSocket _serverSocket;
  StreamSubscription<Socket> _socketSubscriptions;
  StreamController<Message> _controller = StreamController.broadcast();
  Map<String, Socket> _sockets = {};
  Map<String, StreamSubscription> _streamSubscriptions = {};

  static getInstance() async {
    if(_instance == null){
      _instance = NetworkAdapter();
      await _instance._initialize();
    }

    return _instance;
  }

  _initialize() async {
    _datagramSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 6001);
    _datagramSocket.joinMulticast(InternetAddress('233.233.233.233'));

    _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, 6000);
    _socketSubscriptions = _serverSocket.listen((socket){

      _sockets[socket.remoteAddress.address] = socket;
      _streamSubscriptions[socket.remoteAddress.address] = socket.listen((data){
        _onSocketData(socket.remoteAddress.address, data);
      });
    });
  }

  _onSocketData(id, data){
    _controller.add(Message(id, utf8.decode(data)));
  }

  multicast(String data){
    _datagramSocket.send(utf8.encode(data), InternetAddress('233.233.233.233'), 6001);
  }

  send(id, data) async {
    _sockets[id].add(utf8.encode(data));
    _sockets[id].add(utf8.encode('\n'));
    await _sockets[id].flush();
  }

  onData(onData){
    _controller.stream.listen(onData);
  }


  close(){
    for (var key in _sockets.keys) {
      _streamSubscriptions[key].cancel();
      _sockets[key].close();
      _sockets[key].destroy();
    }

    _datagramSocket.close();
    _socketSubscriptions.cancel();
    _serverSocket.close();
    _controller.close();
  }

  getConnections() => _sockets.keys.toList();

}


