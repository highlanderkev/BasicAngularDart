import 'package:angular2/core.dart';
import 'package:angular2/platform/browser.dart';

import 'package:http/http.dart';

import 'package:kpw_admin_blog/app_component.dart';
import 'package:kpw_admin_blog/services/in_memory.dart';

main() {
  bootstrap(AppComponent, [provide(Client, useClass: InMemoryDataService)]);
}
