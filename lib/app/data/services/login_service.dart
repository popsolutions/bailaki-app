import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/pojo/user.dart';

abstract class LoginService{
  Future<User> login(LoginDto loginDto);
}