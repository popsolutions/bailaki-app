import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/partners.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) => _currentIndex = index;
}
