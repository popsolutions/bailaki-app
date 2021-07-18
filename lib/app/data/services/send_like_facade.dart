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
    //TODO: RESOLVER PROBLEMA DO SERVIDOR DEMORANDO PARA CRIAR O MATCH
  //  await _relationService.sendLike(likeDto);

 //   await Future.delayed(Duration(minutes: 1));

    final matches = await _matchService.findByPartnerId(MatchRequestDto(
        currentPartnerId: likeDto.currentUserPartnerId,
        partnerId: likeDto.friendPartnerId));

    if (matches.isNotEmpty) {
      final match = matches.first;
      await _channelService
          .save(CreateChannelDto(match.leftPartnerId, match.rightPartnerId));
    }
  }
}
