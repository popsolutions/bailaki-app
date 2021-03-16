import 'package:odoo_client/app/data/models/deslike_dto.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';

abstract class RelationService{
  Future<void> sendLike(LikeDto likeDto);
  Future<void> sendDeslike(DeslikeDto deslikeDto);
}