import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/user.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
part 'authentication_controller.g.dart';

class AuthenticationController = _AuthenticationControllerBase with _$AuthenticationController;

abstract class _AuthenticationControllerBase with Store {
  
  UserProfile _currentUser;

  UserProfile get currentUser => _currentUser;
  
  void authenticate(UserProfile user){
   _currentUser = user;
  }
  
  void logout(){
   _currentUser = null;
  }
}