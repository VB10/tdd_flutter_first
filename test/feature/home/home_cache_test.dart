import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_flutter_first/home/model/home_model.dart';
import 'package:tdd_flutter_first/product/cache/home_cache.dart';

void main() {
  late IHomeCache homeCache;
  setUp(() {
    SharedPreferences.setMockInitialValues({}); //set values here

    homeCache = HomeCacheShared(time: 10);
  });
  test('Cache It Sample', () async {
    final model = ReqProfile(email: 'aa', name: 'v', username: 'b');
    final result = await homeCache.saveModel(model);
    expect(result, isTrue);
  });

  test('Cache It Get', () async {
    final model = ReqProfile(email: 'aa', name: 'v', username: 'b');
    final _ = await homeCache.saveModel(model);
    final modelCached = await homeCache.getModel();
    expect(modelCached == model, isTrue);
  });

  test('Cache It With Expiry True', () async {
    final model = ReqProfile(email: 'aa', name: 'v', username: 'b');
    final _ = await homeCache.saveModel(model);
    final modelCached = await homeCache.getModelWithoutExpriy();
    expect(modelCached == model, isTrue);
  });

  test('Cache It With Expiry False', () async {
    final model = ReqProfile(email: 'aa', name: 'v', username: 'b');
    final _ = await homeCache.saveModel(model);
    await Future.delayed(Duration(milliseconds: 11));
    final modelCached = await homeCache.getModelWithoutExpriy();
    expect(modelCached == null, isTrue);
  });
}
