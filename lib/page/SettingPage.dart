import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final Map<String, TextEditingController> newControllers = {};
    for (String key in keys) {
      newControllers[key] =
          TextEditingController(text: prefs.getString(key) ?? '');
    }
    setState(() {
      _controllers.addAll(newControllers);
    });
  }

  void _saveSettings(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: _controllers.entries.map((entry) {
          return ListTile(
            title: TextField(
              controller: entry.value,
              decoration: InputDecoration(labelText: entry.key),
              onChanged: (value) => _saveSettings(entry.key, value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
