import 'package:odoo_client/app/data/models/create_channel_dto.dart';
import 'package:odoo_client/app/data/models/like_dto.dart';
import 'package:odoo_client/app/data/services/channel_service.dart';
import 'package:odoo_client/app/data/services/match_service.dart';
import 'package:odoo_client/app/data/services/relation_service.dart';

class SendLikeFacace {
  final MatchService _matchService;
  final RelationService _relationService;
  final ChannelService _channelService;

  SendLikeFacace(
      this._matchService, this._relationService, this._channelService);

  Future<void> sendLike(LikeDto likeDto) async {
    await _relationService.sendLike(likeDto);
  }
}
