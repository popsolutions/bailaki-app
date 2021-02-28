import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/app/data/services/login_facade.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/login_service_impl.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service_impl.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/music_skill_service_impl.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/data/services/partner_service_impl.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';
import 'package:odoo_client/app/data/services/relation_service_impl.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
import 'package:odoo_client/app/data/services/user_service_impl.dart';
import 'package:odoo_client/app/pages/home/home_controller.dart';
import 'package:odoo_client/app/pages/login/login_controller.dart';
import 'package:odoo_client/app/pages/patner/partner_detail_controller.dart';
import 'package:odoo_client/app/pages/profile/my_profile_controller.dart';
import 'package:odoo_client/app/pages/profile/profile_edit_controller.dart';
import 'package:odoo_client/app/pages/settings/preferences_controller.dart';
import 'package:odoo_client/shared/controllers/authentication_controller.dart';
import 'package:odoo_client/shared/controllers/music_genres_controller.dart';
import 'package:odoo_client/shared/controllers/music_skills_controller.dart';

void setupSharedModule() {
  final locator = GetIt.I;

  locator.registerFactory(() => Odoo());

  locator.registerFactory<LoginService>(
    () => LoginServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<UserService>(
    () => UserServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<MusicGenreService>(
    () => MusicGenreServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<MusicSkillService>(
    () => MusicSkillServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<RelationService>(
    () => RelationServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<PartnerService>(
    () => PartnerServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerLazySingleton(() => AuthenticationController());

  locator.registerLazySingleton(() => MusicGenresController());

  locator.registerLazySingleton(() => MusicSkillsController());

  locator.registerFactory(
    () => MyProfileController(),
  );

  locator
      .registerFactory(() => PreferencesController(locator.get<UserService>()));

  locator.registerFactory(
    () => HomeController(locator.get<PartnerService>(),
        locator.get<RelationService>(), Geolocator()),
  );

  locator.registerFactory(
    () => PartnerDetailController(
      locator.get<PartnerService>(),
    ),
  );

  locator.registerFactory(
    () => ProfileEditController(
      locator.get<UserService>(),
    ),
  );

  locator.registerFactory(
    () => LoginController(locator.get<LoginFacade>()),
  );

  locator.registerFactory<LoginFacade>(
    () => LoginFacadeImpl(
      locator.get<LoginService>(),
      locator.get<UserService>(),
      locator.get<MusicGenreService>(),
      locator.get<MusicSkillService>(),
    ),
  );
}
