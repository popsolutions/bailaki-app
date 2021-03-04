import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/pojo/music_genre.dart';
part 'music_genres_controller.g.dart';

class MusicGenresController = _MusicGenresControllerBase
    with _$MusicGenresController;

abstract class _MusicGenresControllerBase with Store {
  @observable
  ObservableList<MusicGenre> _musicGenres = <MusicGenre>[].asObservable();

  ObservableList<MusicGenre> get musicGenres => _musicGenres;

  @observable
  ObservableSet<MusicGenre> _selectedMusicGenres =
      <MusicGenre>{}.asObservable();

  ObservableSet<MusicGenre> get selectedMusicGenres => _selectedMusicGenres;

  @action
  bool addSelected(MusicGenre item) {
    
    return _selectedMusicGenres.add(item);
  }

  @action
  bool removeSelected(MusicGenre item) {
    return _selectedMusicGenres.remove(item);
  }

  @action
  void init(List<MusicGenre> items, List<int> selectedItems) {
    _musicGenres = items.asObservable();
    _selectedMusicGenres = items
        .where((element) => selectedItems.contains(element.id))
        .toSet()
        .asObservable();
  }
}
