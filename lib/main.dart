import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_dependencies.dart';

void main() {
  runApp(FreshMarketApp(dependencies: AppDependencies.mock()));
}
