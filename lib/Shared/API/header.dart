Future<Map<String, dynamic>> headersMapWithoutToken() async {
  Map<String, dynamic> headersData = {
    'Accept': '*/*',
  };
  return headersData;
}

Future<Map<String, dynamic>> headersMapWithoutTokenWithApiPassword() async {
  Map<String, dynamic> headersData = {
    'Accept': '*/*',
    'api_password': '1H5eLbX5QNrGFj7',
    'Content-Type': 'application/json'
  };
  return headersData;
}

Future<Map<String, dynamic>> headersMap(String token) async {
  Map<String, dynamic> headersData = {
    'Authorization': 'Bearer $token',
    'api_password': '1H5eLbX5QNrGFj7',
    "Accept": "application/json",
    'Content-Type': 'application/json'
  };
  return headersData;
}
