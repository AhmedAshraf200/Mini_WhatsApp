import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_whatsapp/contact_page.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String title});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker(); 
  final TextEditingController _nameController = TextEditingController();  // للتحكم في إدخال الاسم

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 24, 21),
      appBar: AppBar(
        title: const Text('Profile',
        style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 24, 21), 
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddContact(title: 'Go to next page',)),
                );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30.0),
          Stack(
            children: [
              GestureDetector(
                onTap: _showFullImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/profile.png') as ImageProvider,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30.0),
                  onPressed: _pickImage, 
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                labelStyle: TextStyle(
                    color: Colors.white, 
                    fontSize: 16, 
                  ),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _image != null
                  ? Image.file(_image!)
                  : const Text('No image selected!'),  
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}