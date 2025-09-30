import 'package:hive/hive.dart';

part 'chat_conversation.g.dart';

@HiveType(typeId: 1)
class ChatConversation extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  DateTime updatedAt;

  @HiveField(4)
  String modelUsed;

  @HiveField(5)
  List<String> messageIds;

  ChatConversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.modelUsed,
    required this.messageIds,
  });
}
