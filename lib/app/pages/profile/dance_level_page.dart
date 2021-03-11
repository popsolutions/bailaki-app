import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:odoo_client/shared/controllers/music_skills_controller.dart';

class DanceLevelPage extends StatefulWidget {
  const DanceLevelPage({Key key}) : super(key: key);
  @override
  _DanceLevelPageState createState() => _DanceLevelPageState();
}

class _DanceLevelPageState extends State<DanceLevelPage> {
  MusicSkillsController _musicSkillsController;

  @override
  void initState() {
    _musicSkillsController = GetIt.I.get<MusicSkillsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _musicSkillsController.selected);
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
                "Nível de dança",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.grey[100]),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: Observer(builder: (_) {
                  final danceLevels = _musicSkillsController.musicSkills;
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      shrinkWrap: true,
                      separatorBuilder: (_, index) => const Divider(),
                      itemBuilder: (_, index) {
                        final item = danceLevels[index];

                        return Observer(builder: (_) {
                          final isSelected =
                              item == _musicSkillsController.selected;
                          return ListTile(
                            dense: true,
                            onTap: () => _musicSkillsController.select(item),
                            trailing: isSelected
                                ? Icon(Icons.check, color: Colors.blue)
                                : null,
                            title: Text(
                              "${item?.name}",
                              style: TextStyle(
                                  color:
                                      isSelected ? Colors.blue : Colors.grey),
                            ),
                          );
                        });
                      },
                      itemCount: danceLevels.length);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
