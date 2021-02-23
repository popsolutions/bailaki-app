import 'package:odoo_client/app/data/models/login_dto.dart';
import 'package:odoo_client/app/data/services/login_facade.dart';
import 'package:odoo_client/app/data/services/login_service.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/music_skill_service.dart';
import 'package:odoo_client/app/data/services/user_service.dart';

class LoginFacadeImpl implements LoginFacade {
  final LoginService _loginService;
  final UserService _userService;
  final MusicGenreService _musicGenreService;
  final MusicSkillService _musicSkillService;
  LoginFacadeImpl(this._loginService, this._userService,
      this._musicGenreService, this._musicSkillService);

  @override
  Future<UserProfile> login(LoginDto loginDto) async {
    final loginResponse = await _loginService.login(loginDto);
    final userProfile =
        await _userService.findProfile(loginResponse.result.partnerId);
    final userData = loginResponse.result;
    return UserProfile(
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
        webBaseUrl: userData.webBaseUrl);
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

  UserProfile(
      {this.name,
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
      this.gender});
}
