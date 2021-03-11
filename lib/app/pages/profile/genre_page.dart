import 'package:flutter/material.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({Key key}) : super(key: key);
  @override
  _GenreePageState createState() => _GenreePageState();
}

class _GenreePageState extends State<GenrePage> {
  List<String> _genrees = ["Homem", "Mulher", "Outro"];

  final dict = {"Homem": "male", "Mulher": "female", "Outro": "other"};
  String _selected;

  void _select(String item) {
    setState(() {
      _selected = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, dict[_selected]);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            leading: Navigator.canPop(context)
                ? BackButton(
                    color: Colors.black,
                  )
                : null,
            title: Text(
              "Gênero",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[100],
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
      ),
    );
  }
}
