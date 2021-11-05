import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:odoo_client/app/data/models/image_dto.dart';
import 'package:odoo_client/app/data/models/memory_image.dart';
import 'package:odoo_client/app/data/models/update_profile_dto.dart';
import 'package:odoo_client/app/data/pojo/music_genre.dart';
import 'package:odoo_client/app/data/pojo/music_skill.dart';
import 'package:odoo_client/app/data/services/image_service.dart';
import 'package:odoo_client/app/data/services/user_service.dart';
import 'package:uuid/uuid.dart';
part 'profile_edit_controller.g.dart';

class ProfileEditController = _ProfileEditControllerBase
    with _$ProfileEditController;

abstract class _ProfileEditControllerBase with Store {
  final UserService _userService;
  final ImageService _imageService;
  final ImagePicker _imagePicker;
  int _partnerId;

  _ProfileEditControllerBase(
      this._userService, this._imageService, this._imagePicker);

  @observable
  ObservableList<Photo> _images = <Photo>[].asObservable();

  ObservableList<Photo> get images => _images;

  @observable
  ObservableFuture _updateProfileRequest = ObservableFuture.value(null);

  ObservableFuture get updateProfileRequest => _updateProfileRequest;

  String _aboutYou;
  String get aboutYou => _aboutYou;

  String _name;
  String get name => _name;

  List<int> _danceStyles;

  List<int> get danceStyleIds => _danceStyles;

  int _danceLevel;
  int get danceLevelId => _danceLevel;

  String _function;
  String get function => _function;

  @observable
  String _gender;
  String get gender => _gender;

  @observable
  DateTime _birthdate;
  DateTime get birthdate => _birthdate;

  @observable
  ObservableFuture _addImageRequest = ObservableFuture.value(null);

  ObservableFuture get addImageRequest => _addImageRequest;

  @observable
  ObservableFuture _removeImageRequest = ObservableFuture.value(null);

  ObservableFuture get removeImageRequest => _removeImageRequest;

  //TODO: tratar erro ao adicionar / remover imagem
  //TODO: comprimir imagens

  void addImage(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return Container(
          // color: goopColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                height: 3,
                width: 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Tire uma foto.'),
                  onPressed: () async {
                    final uuid = Uuid().v4();
                    _imagePicker
                        .getImage(
                      source: ImageSource.camera,
                      imageQuality: 25,
                    )
                        .then((value) async {
                      final bytes = await value.readAsBytes();
                      _imageService
                          .sendFile(ImageDto(_partnerId, uuid, bytes))
                          .then((value) async {
                        _images.add(Photo(
                          id: value,
                          name: uuid,
                          bytes: bytes,
                        ));
                      });
                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .5,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.attach_file_outlined),
                  label: Text('Escolha um arquivo'),
                  onPressed: () async {
                    final uuid = Uuid().v4();
                    _imagePicker
                        .getImage(
                      source: ImageSource.gallery,
                      imageQuality: 25,
                    )
                        .then((value) async {
                      final bytes = await value.readAsBytes();
                      _imageService
                          .sendFile(ImageDto(_partnerId, uuid, bytes))
                          .then((value) async {
                        _images.add(Photo(
                          id: value,
                          name: uuid,
                          bytes: bytes,
                        ));
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void removeImage(Photo image) {
    _images.remove(image);
    _imageService.removeImage(image.id).then((value) {});
  }

  set aboutYou(String value) => _aboutYou = value?.trim();
  set name(String value) => name = value?.trim();
  set danceStyles(List<MusicGenre> items) =>
      _danceStyles = items.map((e) => e.id).toList();
  set danceLevel(MusicSkill value) => _danceLevel = value.id;
  set function(String value) => _function = value?.trim();
  set gender(String value) => _gender = value?.trim();
  set partnerId(int value) => _partnerId = value;
  set birthdate(DateTime value) => _birthdate = value;

  @action
  void submit() {
    _updateProfileRequest = _userService
        .update(UpdateProfileDto(
          name: name,
          birthdate_date: birthdate,
          function: _function,
          gender: _gender,
          music_genre_ids: _danceStyles,
          music_skill_id: _danceLevel,
          partnerId: _partnerId,
          profile_description: _aboutYou,
        ))
        .asObservable();
  }
}
