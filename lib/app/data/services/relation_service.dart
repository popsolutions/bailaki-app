import 'package:odoo_client/app/data/models/like_dto.dart';

abstract class RelationService{
  Future<void> sendLike(LikeDto likeDto);
  Future<void> sendDeslike();
  Future findMatches();
}