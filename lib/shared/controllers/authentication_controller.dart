import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/data/services/user_dao.dart';
part 'authentication_controller.g.dart';

class AuthenticationController = _AuthenticationControllerBase
    with _$AuthenticationController;

abstract class _AuthenticationControllerBase with Store {
  _AuthenticationControllerBase(this._userDao);

  final UserDao _userDao;

  @observable
  ObservableFuture<UserProfile> _currentUser = ObservableFuture.value(null);

  UserProfile get currentUser => _currentUser.value;

  bool get isLoadingUser => _currentUser.status == FutureStatus.pending;

  @action
  void initialAuthentication() {
    _currentUser = _userDao.find().asObservable();
  }

  @action
  void authenticate(UserProfile user) {
    _currentUser = ObservableFuture.value(user);
    _userDao.saveOrReplace(user);
  }

  @action
  void logout() {
    _currentUser = null;
    _userDao.delete();
  }
}
