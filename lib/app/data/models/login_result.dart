import 'package:odoo_client/app/data/pojo/music_genre.dart';
import 'package:odoo_client/app/data/pojo/music_skill.dart';
import 'package:odoo_client/app/data/services/login_facade_impl.dart';

class LoginResult {
  final UserProfile userProfile;
  final List<MusicSkill> musicSkills;
  final List<MusicGenre> musicGenres;

  LoginResult(
    this.userProfile,
    this.musicSkills,
    this.musicGenres,
  );
}
