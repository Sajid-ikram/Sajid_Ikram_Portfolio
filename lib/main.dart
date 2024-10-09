
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sajid_ikram/presentation/utils/extensions/extensions.dart';
import 'package:url_strategy/url_strategy.dart';
import 'custom_layout/layout.dart';
import 'presentation/route/routes.dart';
import 'presentation/utils/custom_scroll_behaviour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  setPathUrlStrategy();
  runApp(const SajidIkram());
}

class SajidIkram extends StatelessWidget {
  const SajidIkram({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: 'Sajid Ikram',
        scrollBehavior: AppScrollBehavior(),
        debugShowCheckedModeBanner: false,

        theme: context.theme(),
        initialRoute: initialRoute,
        onGenerateRoute: RouteGen.generateRoute,
      ),
    );
  }

  String get initialRoute => Routes.home;
}
