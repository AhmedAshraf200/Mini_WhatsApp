import 'package:flutter/material.dart';
import 'package:mini_whatsapp/profile_page.dart';



class VerficationPage extends StatefulWidget {
  const VerficationPage({super.key, required String title});

  @override
  State<VerficationPage> createState() => _VerficationPageState();
}

class _VerficationPageState extends State<VerficationPage> {
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();
  final TextEditingController _digit5Controller = TextEditingController();
  final TextEditingController _digit6Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 24, 21), 
      appBar: AppBar(
        title: const Text('Verification',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 24, 21), 
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter the 6-digit code sent to your number',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigitField(_digit1Controller),
                _buildDigitField(_digit2Controller),
                _buildDigitField(_digit3Controller),
                _buildDigitField(_digit4Controller),
                _buildDigitField(_digit5Controller),
                _buildDigitField(_digit6Controller),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String code = _digit1Controller.text +
                    _digit2Controller.text +
                    _digit3Controller.text +
                    _digit4Controller.text +
                    _digit5Controller.text +
                    _digit6Controller.text;

                if (code.length == 6) {
                  _showCongratulationsDialog(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a 6-digit code'), backgroundColor: Colors.red),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Center(
                child: Text(
                  'Verify',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitField(TextEditingController controller) {
    return SizedBox(
      width: 40,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold, 
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
  void _showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You have successfully verfication.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Go to next page',)),
                );
                _clearTextFields();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _clearTextFields() {
    _digit1Controller.clear();
    _digit2Controller.clear();
    _digit3Controller.clear();
    _digit4Controller.clear();
    _digit5Controller.clear();
    _digit6Controller.clear();
  }
}