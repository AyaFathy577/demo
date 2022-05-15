import 'package:demo/localization/language_constants.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("data"),
            DropdownButton<String>(
              iconSize: 30,
              hint: const Text(""),
              underline: Container(),
              onChanged: (String? value) {
                /// update value
                debugPrint("new value $value");
              },
              items: [
                getTranslated(context, "data0")!,
                getTranslated(context, "data1")!,
                getTranslated(context, "data2")!,
              ]
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
