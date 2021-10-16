import 'package:odoo_client/app/data/models/message.dart';
import 'package:odoo_client/app/data/models/search_message_request_dto.dart';
import 'package:odoo_client/app/data/models/send_message_request_dto.dart';
import 'package:odoo_client/app/data/services/odoo_api.dart';

abstract class MessageService {
  Future<List<DayMessage>> findByChannel(
      SearchMessageRequestDto searchMessageRequestDto);

  Future<void> sendMessage(SendMessageRequestDto sendMessageRequestDto);
}

class MessageServiceImpl implements MessageService {
  final Odoo _odoo;

  MessageServiceImpl(this._odoo);

  @override
  Future<List<DayMessage>> findByChannel(
      SearchMessageRequestDto searchMessageRequestDto) async {
    List domain = [];
    domain.add(['res_id', '=', searchMessageRequestDto.channelId]);
    domain.add(["message_type", "=", "comment"]);
    domain.add(["processLastMessage", "=", "True"]);

    if ((searchMessageRequestDto.lastIdReceived ?? 0) != 0)
      domain.add(["id", ">", searchMessageRequestDto.lastIdReceived]);

    if (searchMessageRequestDto.author_idNot != 0)
      domain.add(["author_id", "<>", searchMessageRequestDto.author_idNot]);

    final response = await _odoo.searchRead('mail.message', domain, []);
    final items = (response.getRecords() as List)
        ?.map<Message>((e) => Message.fromJson(e))
        ?.toList();
    final dates = items.map((e) => _toStringDate(e.date)).toSet();

    return dates
        .map((e) {
      final date = DateTime.parse(e);
      return DayMessage(
          date,
          items
              .where((element) => _toStringDate(element.date) == e)
              .toList().reversed.toList());
    })
        .toList()
        .reversed
        .toList();
  }

  String _toStringDate(DateTime date) {
    return date.toString().split(' ').first;
  }

  @override
  Future<void> sendMessage(SendMessageRequestDto sendMessageRequestDto) async {
    final response = await _odoo.create('mail.message', {
      'author_id': sendMessageRequestDto.currentPartnerId,
      'model': 'mail.channel',
      'res_id': sendMessageRequestDto.channelId,
      'message_type': 'comment',
      'body': sendMessageRequestDto.message,
      'channel_ids': [
        [4, sendMessageRequestDto.channelId, 0]
      ]
    }, 'bailaki_message_post');

    print(response);
  }
}

class DayMessage {
  final DateTime date;
  final List<Message> messages;

  DayMessage(this.date, this.messages);
}
