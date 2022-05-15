import 'package:demo/data_layer/providers/tabs_provider.dart';
import 'package:demo/localization/language_constants.dart';
import 'package:demo/presentation_layer/screens/home_screen.dart';
import 'package:demo/presentation_layer/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool _init = true;
  final List<Widget> children = <Widget>[
    const HomeScreen(
      title: 'Home',
    ),
    const Scaffold(
      body: SettingScreen(),
    ),
    const Scaffold(
      body: Center(child: Text("Shop"),),
    ),
  ];

  @override
  void initState() {
    Provider.of<TabsProvider>(context, listen: false).initCurrentIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabsProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          key: _globalKey,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 30,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Shop',
              ),
            ],
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            currentIndex: provider.currentIndex,
            onTap: (index) {
              // if (isGuest) {
              //   showDialog(
              //     context: context,
              //     builder: (BuildContext context) => CommonAlert(
              //       actionMethod: () =>
              //           Navigator.pushNamed(context, signInPage),
              //       content: getTranslated(context, "you_are_guest")! +
              //           '\n' +
              //           getTranslated(context, "please_sign_in")!,
              //       actionBtn: getTranslated(context, 'ok')!,
              //       cancelBtn: getTranslated(context, 'cancel')!,
              //     ),
              //   );
              // } else {
              provider.updateCurrentIndex(index);
              // }
            },
          ),
          body: WillPopScope(
            onWillPop: () {
              if (_globalKey.currentState!.isDrawerOpen) {
                Navigator.pop(context); // closes the drawer if opened
                return Future.value(false); // won't exit the app
              } else {
                return Future.value(false);
              }
            },
            child: Builder(builder: (context) {
              if (_init) {
                _init = false;
                // _configureFCM();
              }
              return children[provider.currentIndex];
            }),
          ),
        );
      },
    );
  }

  // void _configureFCM() {
  //   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //   _firebaseMessaging.getInitialMessage();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage? event) {
  //     /// event!.data ==> {notification_type: order_status_notification, order_id: 12121, status_id: 19}
  //     debugPrint('event!.data----------FCM-----------\n${event!.data}');
  //     if (event.data['notification_type'] == 'order_status_notification' &&
  //         mounted) {
  //       OrderRepository().updateOrder(
  //           context, event.data['status_id'], event.data['order_id']);
  //       Flushbar(
  //         flushbarPosition: FlushbarPosition.TOP,
  //         flushbarStyle: FlushbarStyle.FLOATING,
  //         reverseAnimationCurve: Curves.decelerate,
  //         forwardAnimationCurve: Curves.elasticOut,
  //         leftBarIndicatorColor: AppColors.primaryColor,
  //         borderRadius: const BorderRadius.all(Radius.circular(8)),
  //         icon: const Icon(Icons.info, color: AppColors.primaryColor),
  //         shouldIconPulse: false,
  //         titleText: Text(
  //           '${event.notification!.title}',
  //           style: const TextStyle(color: AppColors.black, fontSize: 12),
  //         ),
  //         messageText: Text('${event.notification!.body}',
  //             style: const TextStyle(color: AppColors.black, fontSize: 12),
  //             textAlign: TextAlign.start),
  //         duration: const Duration(seconds: 5),
  //         backgroundColor: AppColors.white,
  //       ).show(context);
  //     } else if (event.data['notification_type'] == 'inactive') {
  //       _logOut();
  //     }
  //   });
  // }

  // void _logOut() {
  //   SharedPref sharedPref = SharedPref();
  //   sharedPref.removeAll();
  //   isGuest = true;
  //   Navigator.pushNamedAndRemoveUntil(context, splashPage, (route) => false);
  // }

}
