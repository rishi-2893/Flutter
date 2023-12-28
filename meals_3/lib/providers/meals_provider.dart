import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';

// ref is passed by the riverpod package
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
