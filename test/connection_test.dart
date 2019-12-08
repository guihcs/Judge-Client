


import 'package:flutter_test/flutter_test.dart';
import 'package:judge/network/message.dart';
import 'package:judge/network/network_provider.dart';

void main() {
  test('Connection Test', () async {
    NetworkAdapter adapter = await NetworkAdapter.getInstance();

    Message message;

    adapter.onData( (d){
      message = d;
    });

    adapter.multicast("tiambobo");

    print(message);
  });
}