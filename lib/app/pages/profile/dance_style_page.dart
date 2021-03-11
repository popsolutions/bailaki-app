import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/shared/controllers/music_genres_controller.dart';
import 'package:odoo_client/shared/controllers/music_skills_controller.dart';

class MusicalPreferencesPage extends StatefulWidget {
  const MusicalPreferencesPage({Key key}) : super(key: key);
  @override
  _MusicalPreferencesPageState createState() => _MusicalPreferencesPageState();
}

class _MusicalPreferencesPageState extends State<MusicalPreferencesPage> {
  MusicGenresController _musicGenresController;

  @override
  void initState() {
    _musicGenresController = GetIt.I.get<MusicGenresController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
            context, List.of(_musicGenresController.selectedMusicGenres));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? BackButton(
                  color: Colors.black,
                )
              : null,
          title: Text(
            "Estilos musicais",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 120,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 20, bottom: 15),
                  color: Color.fromRGBO(245, 247, 250, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Selecione os estilos musicais que você gostaria de compartilhar com as pessoas."),
                      Text(
                        "ESTILOS MUSICAIS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(92, 92, 92, 1),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Observer(builder: (_) {
                  return Wrap(
                    spacing: 10,
                    children: _musicGenresController.musicGenres.map((item) {
                      final isSelected = _musicGenresController
                          .selectedMusicGenres
                          .contains(item);
                      return MusicalPreferenceTile(
                        title: item.name,
                        isSelected: isSelected,
                        onPressed: () {
                          if (!_musicGenresController.addSelected(item)) {
                            _musicGenresController.removeSelected(item);
                          }
                        },
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicalPreferenceTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const MusicalPreferenceTile(
      {Key key, this.title, this.isSelected, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputChip(
      showCheckmark: false,
      label: Text(title),
      selectedColor: Colors.white,
      onPressed: onPressed,
      backgroundColor: Colors.white,
      padding: EdgeInsets.zero,
      deleteButtonTooltipMessage: "remove music preference",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
              width: 0.7, color: isSelected ? Colors.blue : Colors.grey)),
/*
      deleteIcon: CircleAvatar(
        radius: 8,
        backgroundColor: Colors.red,
        child: Icon(Icons.close, size: 10),
      ),
*/
    );
  }
}
