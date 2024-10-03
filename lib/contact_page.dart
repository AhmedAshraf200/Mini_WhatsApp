import 'package:flutter/material.dart';
import 'package:mini_whatsapp/chats_list.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key, required String title});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      // Save the contact logic can go here
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Contact saved successfully!'),
        backgroundColor: Colors.green,
      ));
      // Clear the fields after saving
      _nameController.clear();
      _phoneController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 24, 21),
      appBar: AppBar(
        title: const Text('Add Contact',
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
                  MaterialPageRoute(builder: (context) => const ChatsList(title: 'Go to next page',)),
                );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // WhatsApp-like color
                ),
                child: const Text('Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}