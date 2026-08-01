import 'package:flutter/widgets.dart';
import 'bootstrap/app_bootstrap.dart';

Future<void> main() async {
  final bootstrap = await AppBootstrap.create();
  runApp(bootstrap.buildApp());
}
