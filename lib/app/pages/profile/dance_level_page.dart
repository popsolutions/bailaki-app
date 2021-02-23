
import 'package:flutter/material.dart';

class DanceLevelPage extends StatefulWidget {
  const DanceLevelPage({Key key}) : super(key: key);
  @override
  _DanceLevelPageState createState() => _DanceLevelPageState();
}

class _DanceLevelPageState extends State<DanceLevelPage> {
  List<String> _danceLevels = [
    "Quero aprender",
    "Básico",
    "Intermediário",
    "Avançado",
  ];

  String _selected;

  void _select(String item) {
    setState(() {
      _selected = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Nível de dança"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListView.separated(
                  padding: const EdgeInsets.only(top: 5, bottom: 20),
                  shrinkWrap: true,
                  separatorBuilder: (_, index) => const Divider(),
                  itemBuilder: (_, index) {
                    final item = _danceLevels[index];
                    final isSelected = _selected == item;
                    return ListTile(
                      dense: true,
                      onTap: () => _select(item),
                      trailing: isSelected
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                      title: Text(
                        item,
                        style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.grey),
                      ),
                    );
                  },
                  itemCount: _danceLevels.length),
            ),
          ],
        ),
      ),
    );
  }
}
