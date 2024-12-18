import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isswitched = true;
  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  // Load the switch state from SharedPreferences
  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isswitched = prefs.getBool('switchState') ??
          true; // Default to true if no saved value
    });
  }

  // Save the switch state to SharedPreferences
  void _saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchState', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Notifications"),
      body: Column(
        children: [
          ListTile(
            leading: const Text(
              "Notifications",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            trailing: Switch(
              value: isswitched,
              onChanged: (value) {
                setState(() {
                  isswitched = value;
                });
                _saveSwitchState(value);
              },
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black26,
            indent: 12,
            endIndent: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: isswitched == true
                ? const Text(
                    "Disable notifications to stop receiving updates about orders, promotions, and alerts. ")
                : const Text(
                    "Enable notifications to stay updated with order status, special offers, and important updates."),
          ),
        ],
      ),
    );
  }
}
