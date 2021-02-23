import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/music_genre.dart';
import 'package:odoo_client/app/data/services/music_genre_service.dart';
part 'musical_preferences_controller.g.dart';

class MusicalPreferencesController = _MusicalPreferencesControllerBase
    with _$MusicalPreferencesController;

abstract class _MusicalPreferencesControllerBase with Store {
  final MusicGenreService _musicGenreService;

  _MusicalPreferencesControllerBase(this._musicGenreService);

  @observable
  ObservableFuture<List<MusicGenre>> _musicGenreRequest =
      ObservableFuture.value(null);

 
  ObservableFuture<List<MusicGenre>> get musicGenreRequest =>
      _musicGenreRequest;

  @action
  void load() {
    _musicGenreRequest = _musicGenreService.findAll().asObservable();
  }
}
