
final AuthManager authManager = AuthManager();
class AuthManager {
  final Map<String, dynamic> _authData = {};

  /// Save the data returned from the login function
  void saveData(String key, dynamic data) {
    _authData[key] = data;

  }

  /// Delete the saved data by key
  void deleteData(String key) {
    if (_authData.containsKey(key)) {
      _authData.remove(key);
      print("Data deleted: $key");
    } else {
      print("Key not found: $key");
    }
  }

  /// Retrieve saved data by key (optional utility function)
  dynamic getData(String key) {
    return _authData[key];
  }
}
