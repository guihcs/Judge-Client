

class Message {
  String _text, _address, _type;

  Message(this._address, this._text);


  String get text => _text;

  get address => _address;

  get type => _type;

  @override
  String toString() {
    return 'Message{_text: $_text, _address: $_address, _type: $_type}';
  }

}