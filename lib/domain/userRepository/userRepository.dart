class UserRepository {
  Future<String> autenticateUser(
      {required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<String> createUser(
      {required String email,
      required String password,
      required String name,
      required String username}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }
}
