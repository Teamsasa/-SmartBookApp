import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = '日本語';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('通知'),
            subtitle: const Text('アプリからの通知を受け取る'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('言語'),
            subtitle: Text(_selectedLanguage),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          ListTile(
            title: const Text('アカウント設定'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // アカウント設定画面に遷移する処理を実装
            },
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // プライバシーポリシー画面に遷移する処理を実装
            },
          ),
          ListTile(
            title: const Text('アプリについて'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // アプリについての情報を表示する処理を実装
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('言語を選択'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedLanguage = '日本語';
                });
                Navigator.pop(context);
              },
              child: const Text('日本語'),
            ),
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  _selectedLanguage = 'English';
                });
                Navigator.pop(context);
              },
              child: const Text('English'),
            ),
          ],
        );
      },
    );
  }
}
