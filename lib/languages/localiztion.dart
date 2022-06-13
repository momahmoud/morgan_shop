import 'package:get/get.dart';
import 'package:morgan_shop/languages/ar.dart';
import 'package:morgan_shop/languages/en.dart';
import 'package:morgan_shop/languages/fr.dart';

import '../utils/my_string.dart';

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ara: ar,
        ene: en,
        fre: fr,
      };
}
