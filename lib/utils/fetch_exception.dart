class FetchException implements Exception{
  String _message;
  FetchException(this._message);
  String toString(){
    return '$_message';
  }
}