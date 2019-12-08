

import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:judge/network/message.dart';
import 'package:judge/network/network_provider.dart';

class JudgeBloc extends BlocBase{

  NetworkAdapter _networkProvider;

  String _serverAddress;

  bool _isMulticasting = false;
  bool _isConnected = false;
  int _numberOfTries = 10;

  String _judgeName;
  String _judgeCode;
  Function _callback;

  initialize() async {
     _networkProvider = await NetworkAdapter.getInstance();

     //Message received callback
     _networkProvider.onData((Message data){
       _serverAddress ??= data.address;

       _routeMessage(jsonDecode(data.text));

     });
  }

  //Multicast to all in group
  startMulticast(String code) async {

    _isMulticasting = true;

    for(int i = 0; i < _numberOfTries && _isMulticasting; i++){
      _networkProvider.multicast(code);
      await Future.delayed(Duration(milliseconds: 600));
    }

    _isMulticasting = false;
  }

  //send data to server
  sendFormToServer(Map<String, dynamic> result, Map<String, dynamic> args) async {

    result['type'] = 'form-response';
    result['judge'] = _judgeCode;
    result['team'] = args['team']['name'];

    await _networkProvider.send(_serverAddress, jsonEncode(result));
  }

  //stop multicasting packets
  stopMulticast(){
    _isMulticasting = false;
  }



  //when form is received
  onFormReceived(callback){
    this._callback = callback;
  }

  //route incoming messages
  _routeMessage(Map<String, dynamic> data){
    switch(data['type']){
      case 'form-request': {
        if(_callback != null) _callback(data);
        break;
      }
      default: {
        _isConnected = true;
        _isMulticasting = false;

        _judgeName = data['name'];
        _judgeCode = data['code'];
        break;
      }
    }

  }

  get isConnected => _isConnected;
  get judgeName => _judgeName;

  @override
  void dispose() {
    super.dispose();
  }
}