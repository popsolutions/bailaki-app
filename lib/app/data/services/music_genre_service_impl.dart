import 'package:odoo_client/app/data/pojo/music_genre.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

class MusicGenreServiceImpl implements MusicGenreService {
  final Odoo _odoo;

  MusicGenreServiceImpl(this._odoo);
  @override
  Future<List<MusicGenre>> findAll() async {
    final response = await _odoo.searchRead(
      'res.partner.music.genre',
      [],
      ["id", "name"],
    );

    final items = response
        .getRecords()
        .map<MusicGenre>((e) => MusicGenre.fromJson(e))
        .toList();
    return items;
  }
}
