import 'package:flutter/material.dart';
import 'package:mini_whatsapp/chat_page.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key, required String title});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  final List<Map<String, String>> chats = [
    {
      "name": "Ahmed Ashraf",
      "message": "Hey, how are you?",
      "time": "2:00 PM",
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "John Doe",
      "message": "Can we meet tomorrow?",
      "time": "1:45 PM",
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Emily Clark",
      "message": "Great job on the project!",
      "time": "12:30 PM",
      "image": "https://via.placeholder.com/150"
    },
  ];

  List<Map<String, String>> filteredChats = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    filteredChats = chats;
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      isSearching = false;
      filteredChats = chats;
    });
  }

  void _filterChats(String query) {
    List<Map<String, String>> results = [];
    if (query.isEmpty) {
      results = chats;
    } else {
      results = chats.where((chat) => chat['name']!.toLowerCase().contains(query.toLowerCase())).toList();
    }

    setState(() {
      filteredChats = results;
    });
  }

  void _showMenuOptions() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000, 80, 0, 0), 
      items: [
        const PopupMenuItem<String>(
          value: '1',
          child: Text('New Group'),
        ),
        const PopupMenuItem<String>(
          value: '2',
          child: Text('Setting'),
        ),
        const PopupMenuItem<String>(
          value: '3',
          child: Text('Logout'),
        ),
      ],
    ).then((value) {
      if (value == '1') {
      } else if (value == '2') {
      } else if (value == '3') {
      }
    });
  }

  AppBar buildAppBar() {
    if (isSearching) {
      return AppBar(
        backgroundColor: Colors.teal,
        leading: BackButton(onPressed: _stopSearching),
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Searching...',
            border: InputBorder.none,
          ),
          onChanged: _filterChats,
        ),
      );
    } else {
      return AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.teal,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _startSearch,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: _showMenuOptions,
              ),
            ],
          ),
        ],
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView.builder(
        itemCount: filteredChats.length,
        itemBuilder: (context, index) {
          final chat = filteredChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['image']!),
              radius: 30,
            ),
            title: Text(chat['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(chat['message']!),
            trailing: Text(chat['time']!),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage(title: 'Go to next page', contactName: 'Ahmed Ashraf', isOnline: true,)),
                );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
