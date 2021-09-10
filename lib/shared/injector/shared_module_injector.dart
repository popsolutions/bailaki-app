import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:odoo_client/app/data/services/channel_facade.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/image_service.dart';
import 'package:odoo_client/app/data/services/image_service_impl.dart';
import 'package:odoo_client/app/data/services/location_service.dart';
import 'package:odoo_client/app/data/services/location_service_impl.dart';
import 'package:odoo_client/app/data/services/login_facade.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/login_service_impl.dart';
import 'package:odoo_client/app/data/services/match_service.dart';
import 'package:odoo_client/app/data/services/message_dao.dart';
import 'package:odoo_client/app/data/services/message_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service_impl.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/music_skill_service_impl.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';
import 'package:odoo_client/app/data/services/partner_service.dart';
import 'package:odoo_client/app/data/services/partner_service_impl.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';
import 'package:odoo_client/app/data/services/relation_service_impl.dart';
import 'package:odoo_client/app/data/services/send_like_facade.dart';
import 'package:odoo_client/app/data/services/user_dao.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
import 'package:odoo_client/app/data/services/user_service_impl.dart';
import 'package:odoo_client/app/pages/home/home_controller.dart';
import 'package:odoo_client/app/pages/home/select_partner_controller.dart';
import 'package:odoo_client/app/pages/login/login_controller.dart';
import 'package:odoo_client/app/pages/match/chat_controller.dart';
import 'package:odoo_client/app/pages/match/match_controller.dart';
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

  locator.registerFactory<MatchService>(
    () => MatchServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<ChannelService>(
    () => ChannelServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory<MessageService>(
    () => MessageServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerFactory(() => MessageDao());

  locator.registerFactory<UserDao>(() => UserDaoImpl());

  locator
      .registerFactory<LocationService>(() => LocationServiceImpl(Location()));

  locator.registerFactory<ImageService>(
    () => ImageServiceImpl(
      locator.get<Odoo>(),
    ),
  );

  locator.registerLazySingleton(() => AuthenticationController(locator.get<UserDao>()));

  locator.registerLazySingleton(() => MusicGenresController());

  locator.registerLazySingleton(() => MusicSkillsController());

  locator.registerFactory(
    () => MyProfileController(),
  );

  locator.registerFactory(
    () => PreferencesController(
      locator.get<UserService>(),
    ),
  );

  locator.registerFactory(
    () => HomeController(
      locator.get<LocationService>(),
      locator.get<UserService>(),
    ),
  );

  locator.registerFactory(
    () => SelectPartnerController(
      locator.get<PartnerService>(),
      locator.get<RelationService>(),
      locator.get<SendLikeFacace>(),
    ),
  );

  locator.registerFactory(
    () => PartnerDetailController(
      locator.get<PartnerService>(),
    ),
  );

  locator.registerFactory(
    () => ProfileEditController(
      locator.get<UserService>(),
      locator.get<ImageService>(),
      ImagePicker(),
    ),
  );

  locator.registerFactory(
    () => LoginController(locator.get<LoginFacade>()),
  );

  locator.registerFactory(
    () => ChatController(
        locator.get<MessageService>(), locator.get<MessageDao>()),
  );

  locator.registerFactory(
    () => MatchController(
      locator.get<ChannelFacade>(),
    ),
  );

  locator.registerFactory(
    () => SendLikeFacace(
      locator.get<MatchService>(),
      locator.get<RelationService>(),
      locator.get<ChannelService>(),
    ),
  );

  locator.registerFactory<LoginFacade>(
    () => LoginFacadeImpl(
        locator.get<LoginService>(),
        locator.get<UserService>(),
        locator.get<MusicGenreService>(),
        locator.get<MusicSkillService>(),
        locator.get<ImageService>()),
  );

  locator.registerFactory<ChannelFacade>(
    () => ChannelFacade(
      locator.get<ChannelService>(),
      locator.get<MatchService>(),
    ),
  );
}
