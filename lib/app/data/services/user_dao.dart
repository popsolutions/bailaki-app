import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';

abstract class UserDao {

  Stream<UserProfile> findAsStream();

  Future<UserProfile> find();

  Future<void> saveOrReplace(UserProfile user);

  Future<void> delete();

}

class UserDaoImpl implements UserDao {
  static const _usersBoxKey = 'users';
  final _userBox = Hive.openBox(_usersBoxKey);

  Stream<UserProfile> findAsStream() async* {
    final box = await _userBox;
    box.watch(key: _usersBoxKey).map((event) =>
        event.deleted ? null : UserProfile.fromJson(jsonDecode(event.value)));
  }

  Future<UserProfile> find() async {
    final box = await _userBox;
    final data = box.get(_usersBoxKey);
    if (data != null) {
      return UserProfile.fromJson(jsonDecode(data));
    }
    return null;
  }

  Future<void> saveOrReplace(UserProfile user) async {
    final box = await _userBox;
    return box.put(_usersBoxKey, jsonEncode(user));
  }

  Future<void> delete() async {
    final box = await _userBox;
    return box.delete(_usersBoxKey);
  }
}
