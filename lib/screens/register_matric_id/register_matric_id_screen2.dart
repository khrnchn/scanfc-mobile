import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcRegistrationPage extends StatefulWidget {
  @override
  _NfcRegistrationPageState createState() => _NfcRegistrationPageState();
}

class _NfcRegistrationPageState extends State<NfcRegistrationPage> {
  bool _isNfcAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkNfcAvailability();
  }

  Future<void> _checkNfcAvailability() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    setState(() {
      _isNfcAvailable = availability == NFCAvailability.available;
    });
  }

  Future<void> _registerNfcCard() async {
    var uid = await FlutterNfcKit.readNDEFRecords();
    print(FlutterNfcKit.readNDEFRawRecords().toString());
    // send uid to server to register matric card
    _showRegistrationCompleteDialog();
  }

  Future<void> _showRegistrationCompleteDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Complete"),
          content: Text("Your NFC card has been registered as a matric card."),
          actions: [
            ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC Registration"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isNfcAvailable)
              Text(
                "NFC is not available on this device.",
                style: TextStyle(fontSize: 20),
              ),
            if (_isNfcAvailable)
              ElevatedButton(
                child: Text("Register NFC Card"),
                onPressed: _registerNfcCard,
              ),
          ],
        ),
      ),
    );
  }
}
