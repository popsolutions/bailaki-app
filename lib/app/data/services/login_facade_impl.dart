import 'package:latlng/latlng.dart';
import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/models/login_result.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/services/image_service.dart';
import 'package:odoo_client/app/data/services/login_facade.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/user_service.dart';

class LoginFacadeImpl implements LoginFacade {
  final LoginService _loginService;
  final UserService _userService;
  final ImageService _imageService;
  final MusicGenreService _musicGenreService;
  final MusicSkillService _musicSkillService;
  LoginFacadeImpl(
    this._loginService,
    this._userService,
    this._musicGenreService,
    this._musicSkillService,
    this._imageService,
  );

  @override
  Future<LoginResult> login(LoginDto loginDto) async {
    final loginResponse = await _loginService.login(loginDto);
    final userData = loginResponse.result;
    final userProfile = await _userService.findProfile(userData.partnerId);
    final images = await _imageService.findByPartner(userData.partnerId);

    final fullUserProfile = UserProfile(
        referredFriendsIds: userProfile.referredFriendsIds,
        images: images,
        position: userProfile.position,
        interestFemales: userProfile.interestFemales,
        interestMales: userProfile.interestMales,
        interestOtherGenres: userProfile.interestOtherGenres,
        refferedMaxFriendDistance: userProfile.refferedFriendMaxDistance,
        name: userData.name,
        birthdate_date: userProfile.birthdate_date,
        companyId: userData.companyId,
        function: userProfile.function,
        gender: userProfile.gender,
        isAdmin: userData.isAdmin,
        music_genre_ids: userProfile.music_genre_ids,
        music_skill_id: userProfile.music_skill_id,
        odoobotInitialized: userData.odoobotInitialized,
        partnerDisplayName: userData.partnerDisplayName,
        partnerId: userData.partnerId,
        profile_description: userProfile.profile_description,
        sessionId: userData.sessionId,
        uid: userData.uid,
        userCompanies: userData.userCompanies,
        webBaseUrl: userData.webBaseUrl,
        enableMatchNotification: userProfile.enableMatchNotification,
        enableMessageNotification: userProfile.enableMessageNotification,
        referredFriendMaxAge: userProfile.referredFriendMaxAge,
        referredFriendMinAge: userProfile.referredFriendMinAge);
    final musicSkills = await _musicSkillService.findAll();
    final musicGenres = await _musicGenreService.findAll();

    return LoginResult(fullUserProfile, musicSkills, musicGenres);
  }
}

class UserProfile {
  final String sessionId;
  final int uid;
  final bool isAdmin;
  final String partnerDisplayName;
  final int companyId;
  final int partnerId;
  final bool userCompanies;
  final String webBaseUrl;
  final bool odoobotInitialized;
  final String profile_description;
  final List<int> music_genre_ids;
  final int music_skill_id;
  final String function;
  final DateTime birthdate_date;
  final String gender;
  final String name;
  final bool interestMales;
  final bool interestFemales;
  final bool interestOtherGenres;
  final int refferedMaxFriendDistance;
  final bool enableMessageNotification;
  final bool enableMatchNotification;
  final int referredFriendMinAge;
  final int referredFriendMaxAge;
  final LatLng position;
  final List<Photo> images;
  final List<int> referredFriendsIds;
  UserProfile(
      {this.interestMales,
      this.interestFemales,
      this.interestOtherGenres,
      this.refferedMaxFriendDistance,
      this.name,
      this.sessionId,
      this.uid,
      this.isAdmin,
      this.partnerDisplayName,
      this.companyId,
      this.partnerId,
      this.userCompanies,
      this.webBaseUrl,
      this.odoobotInitialized,
      this.profile_description,
      this.music_genre_ids,
      this.music_skill_id,
      this.function,
      this.birthdate_date,
      this.gender,
      this.enableMatchNotification,
      this.enableMessageNotification,
      this.referredFriendMinAge,
      this.referredFriendMaxAge,
      this.position,
      this.images,
      this.referredFriendsIds});

  UserProfile copyWith(
      {String sessionId,
      int uid,
      bool isAdmin,
      String partnerDisplayName,
      int companyId,
      int partnerId,
      bool userCompanies,
      String webBaseUrl,
      bool odoobotInitialized,
      String profile_description,
      List<int> music_genre_ids,
      int music_skill_id,
      String function,
      DateTime birthdate_date,
      String gender,
      String name,
      bool interestMales,
      bool interestFemales,
      bool interestOtherGenres,
      int refferedMaxFriendDistance,
      bool enableMessageNotification,
      bool enableMatchNotification,
      int referredFriendMinAge,
      int referredFriendMaxAge,
      LatLng position,
      List<Photo> images,
      List<int> referredFriendsIds}) {
    return UserProfile(
        position: position ?? this.position,
        sessionId: sessionId ?? this.sessionId,
        uid: uid ?? this.uid,
        isAdmin: isAdmin ?? this.isAdmin,
        partnerDisplayName: partnerDisplayName ?? this.partnerDisplayName,
        companyId: companyId ?? this.companyId,
        partnerId: partnerId ?? this.partnerId,
        userCompanies: userCompanies ?? this.userCompanies,
        webBaseUrl: webBaseUrl ?? this.webBaseUrl,
        odoobotInitialized: odoobotInitialized ?? this.odoobotInitialized,
        profile_description: profile_description ?? this.profile_description,
        music_genre_ids: music_genre_ids ?? this.music_genre_ids,
        music_skill_id: music_skill_id ?? this.music_skill_id,
        function: function ?? this.function,
        birthdate_date: birthdate_date ?? this.birthdate_date,
        gender: gender ?? this.gender,
        name: name ?? this.name,
        interestMales: interestMales ?? this.interestMales,
        interestFemales: interestFemales ?? this.interestFemales,
        interestOtherGenres: interestOtherGenres ?? this.interestOtherGenres,
        refferedMaxFriendDistance:
            refferedMaxFriendDistance ?? this.refferedMaxFriendDistance,
        enableMatchNotification:
            enableMatchNotification ?? this.enableMatchNotification,
        enableMessageNotification:
            enableMessageNotification ?? this.enableMessageNotification,
        referredFriendMaxAge: referredFriendMaxAge ?? this.referredFriendMaxAge,
        referredFriendMinAge: referredFriendMinAge ?? this.referredFriendMinAge,
        images: images ?? this.images,
        referredFriendsIds: referredFriendsIds);
  }

  Photo get avatar => images.isNotEmpty ? images.first : null;
}
