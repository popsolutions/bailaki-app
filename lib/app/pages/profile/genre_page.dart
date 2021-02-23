
import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key key}) : super(key: key);
  @override
  _GenreePageState createState() => _GenreePageState();
}

class _GenreePageState extends State<GenrePage> {
  List<String> _genrees = ["Homem", "Mulher", "Outro"];
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
          title: Text("Gênero"),
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
                    final item = _genrees[index];
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
                  itemCount: 3),
            ),
          ],
        ),
      ),
    );
  }
}