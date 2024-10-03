import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.contactName, required this.isOnline, required String title});
  final String contactName;
  final bool isOnline;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add({"type": "text", "content": message});
        _controller.clear();
      });
    }
  }

  void _sendPhoto() {
    // Placeholder for sending a photo
    setState(() {
      messages.add({"type": "photo", "content": "تم إرسال صورة"});
    });
  }

  void _sendVoice() {
    // Placeholder for sending a voice message
    setState(() {
      messages.add({"type": "voice", "content": "تم إرسال رسالة صوتية"});
    });
  }

  void _sendAttachment() {
    // Placeholder for sending an attachment
    setState(() {
      messages.add({"type": "attachment", "content": "تم إرسال مرفق"});
    });
  }

  void _sendEmoji() {
    // Placeholder for sending emojis
    setState(() {
      messages.add({"type": "emoji", "content": "😊"});
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.contactName),
          Text(
            widget.isOnline ? 'Online' : 'Offline',
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call),
          onPressed: () {
            // إجراء مكالمة هاتفية
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {
            // إجراء مكالمة فيديو
          },
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            // تنفيذ الإجراء المطلوب من القائمة
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: '1',
                child: Text('clear'),
              ),
              const PopupMenuItem<String>(
                value: '2',
                child: Text('block contact'),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: _sendEmoji,
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _sendAttachment,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _sendPhoto,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'send message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: _sendVoice,
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget buildMessage(Map<String, String> message) {
    switch (message["type"]) {
      case "text":
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(message["content"]!),
          ),
        );
      case "photo":
      case "voice":
      case "attachment":
      case "emoji":
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(message["content"]!),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessage(messages[index]);
              },
            ),
          ),
          buildMessageInput(),
        ],
      ),
    );
  }
}