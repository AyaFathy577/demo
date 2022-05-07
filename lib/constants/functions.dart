import 'package:demo/data_layer/providers/counter_provider.dart';
import 'package:demo/data_layer/providers/tabs_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:demo/data_layer/providers/language_provider.dart';

class Functions {
  Functions._();
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider.value(value: LanguageProvider()),
      ChangeNotifierProvider.value(value: CounterProvider()),
      ChangeNotifierProvider.value(value: TabsProvider()),
    ];
  }
}
