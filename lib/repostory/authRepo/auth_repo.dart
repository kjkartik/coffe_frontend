abstract class AuthRepo {
  Future<dynamic> login(Map<dynamic,dynamic>data ,dynamic url);
  Future<dynamic> register(Map<dynamic,dynamic>data ,dynamic url);

}