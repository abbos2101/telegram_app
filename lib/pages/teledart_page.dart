import 'package:flutter/material.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TeleDartPage extends StatefulWidget {
  const TeleDartPage({Key? key}) : super(key: key);

  @override
  _TeleDartPageState createState() => _TeleDartPageState();
}

class _TeleDartPageState extends State<TeleDartPage> {
  late TeleDart teledart;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final telegram = Telegram("5062640514:AAHi3pu1rLmU2Xth0KvlBk50c-swObaEeDs");
    final event = Event((await telegram.getMe()).username!);
    teledart = TeleDart(telegram, event);
    teledart.start();
    teledart.setWebhook();
    teledart.onMessage().listen((event) {
      teledart.replyMessage(event, "Salom namuna");
      print(event.text);
    });
  }

  @override
  void dispose() {
    teledart.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teledart")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Message event = Message(
            date: DateTime.now().millisecond +
                const Duration(hours: 3).inMilliseconds,
            chat: Chat(
              id: 468051408,
              type: 'private',
            ),
            message_id: 1471,
          );
          // teledart.onMessage(keyword: "start").listen((event) {
          //   teledart.replyMessage(event, "text");
          //   print(event.toJson());
          // });
        },
      ),
    );
  }
}
