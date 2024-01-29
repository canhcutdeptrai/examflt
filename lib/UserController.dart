import 'DatabaseHelper.dart';
import 'User.dart';

class UserController {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> addUser(User user) async {
    return await _databaseHelper.insert(user);
  }

  Future<List<User>> getAllUsers() async {
    return await _databaseHelper.queryAllRows();
  }

  Future<int> updateUser(User user) async {
    return await _databaseHelper.update(user);
  }

  Future<int> deleteUser(int id) async {
    return await _databaseHelper.delete(id);
  }
}
