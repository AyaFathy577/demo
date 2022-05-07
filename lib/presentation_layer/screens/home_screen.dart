import 'package:demo/data_layer/models/language_model.dart';
import 'package:demo/data_layer/providers/counter_provider.dart';
import 'package:demo/localization/language_constants.dart';
import 'package:demo/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              getTranslated(context, "num_of_push")!,
            ),
            Consumer<CounterProvider>(
              builder: (context, provider, _) {
                return Text(
                  '${provider.counter}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<Language>(
                iconSize: 30,
                hint: const Text("Change language"),
                onChanged: (Language? language) =>
                    _changeLanguage(context, language!),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<CounterProvider>(context).incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _changeLanguage(BuildContext context, Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
}
