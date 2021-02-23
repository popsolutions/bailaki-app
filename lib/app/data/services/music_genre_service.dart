import 'package:odoo_client/app/data/pojo/music_genre.dart';

abstract class MusicGenreService {
  Future<List<MusicGenre>> findAll();
}
