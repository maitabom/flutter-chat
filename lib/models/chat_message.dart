class ChatMessage {
  final String id;
  final String text;
  final DateTime create;
  final String userId;
  final String userName;
  final String userImagemUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.create,
    required this.userId,
    required this.userName,
    required this.userImagemUrl,
  });
}
