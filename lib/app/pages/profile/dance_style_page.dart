import 'package:flutter/material.dart';

class MusicalPreferencesPage extends StatefulWidget {
  const MusicalPreferencesPage({Key key}) : super(key: key);
  @override
  _MusicalPreferencesPageState createState() => _MusicalPreferencesPageState();
}

class _MusicalPreferencesPageState extends State<MusicalPreferencesPage> {
  List<String> _musicalPreferences = [
    "Arrocha",
    "Axé",
    "Bachata",
    "Black Music",
    "Bolero",
    "Dança de rua",
    "Dança de salão",
    "Eletrônica",
    "Flashback",
    "Forró",
    "Funk",
    "Hip Hop",
    "Kizomba",
    "Reggaeton",
    "Rock and Roll",
    "Rockabilly",
    "Salsa e Merengue",
    "Samba de gafiera",
    "Samba rock",
    "Sertanejo & Country",
    "Tango",
    "Tecnobrega",
    "Vanerão",
    "Zouk",
    "Zumba",
    "Lindy Hope",
    "K-Pop"
  ];

  Set<String> _selecteds = {};

  void _addSelected(String item) {
    _selecteds.add(item);
    setState(() {});
  }

  void _deleteSelected(String item) {
    _selecteds.remove(item);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Estilos musicais"),
        centerTitle: true,
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
              child: Wrap(
                spacing: 10,
                children: _musicalPreferences
                    .map((item) => MusicalPreferenceTile(
                          title: item,
                          isSelected: _selecteds.contains(item),
                          onPressed: () {
                            if (!_selecteds.contains(item))
                              _addSelected(item);
                            else
                              _deleteSelected(item);
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
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
