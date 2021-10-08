import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/models/login_result.dart';
import 'package:odoo_client/app/data/services/login_facade.dart';
import 'package:odoo_client/app/utility/global.dart';
import 'package:url_launcher/url_launcher.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginFacade _loginService;

  _LoginControllerBase(this._loginService);

  @observable
  String _email;

  @observable
  String _password;

  @observable
  ObservableFuture<LoginResult> _loginRequest = ObservableFuture.value(null);

  String get email => _email;
  String get password => _password;

  ObservableFuture<LoginResult> get loginRequest => _loginRequest;

  @computed
  bool get isLoading => _loginRequest.status == FutureStatus.pending;
  set email(String email) => _email = email.trim();
  set password(String password) => _password = password.trim();

  void signUp() async {
    String url = globalConfig.serverURLRegisterPage;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void submit() {
    _loginRequest =
        _loginService.login(LoginDto(email, password)).asObservable();
  }
}
