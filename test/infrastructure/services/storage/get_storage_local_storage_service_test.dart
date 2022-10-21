import 'package:flutter_test/flutter_test.dart';

import '../../../domain/services/storage/mock/local_storage_service_mock.dart';

void main() {
  group('Tests over Get Storage Local Storage Service', () {
    final LocalStorageServiceMock localStorageServiceMock = LocalStorageServiceMock();

    test('Tests over Get Storage Local Storage Service - writing/reading elements', () async {
      await localStorageServiceMock.write('test1', 'test');
      await localStorageServiceMock.write('test2', true);
      await localStorageServiceMock.write('test3', 12345);

      assert(localStorageServiceMock.hasData('test1'), 'LocalStorage with key test1 must has data');
      assert(localStorageServiceMock.hasData('test2'), 'LocalStorage with key test2 must has data');
      assert(localStorageServiceMock.hasData('test3'), 'LocalStorage with key test3 must has data');

      assert(localStorageServiceMock.read('test1') as String == 'test', 'LocalStorage with key test1 must has test');
      assert(localStorageServiceMock.read('test2') as bool == true,  'LocalStorage with key test2 must has true');
      assert(localStorageServiceMock.read('test3') as int == 12345, 'LocalStorage with key test3 must has 1234');
    });

    test('Tests over Get Storage Local Storage Service - writing in memory/reading elements', () async {
      localStorageServiceMock
        ..writeInMemory('test4', 'test')
        ..writeInMemory('test5', true)
        ..writeInMemory('test6', 12345);

      assert(localStorageServiceMock.hasData('test4'), 'LocalStorage with key test4 must has data');
      assert(localStorageServiceMock.hasData('test5'), 'LocalStorage with key test5 must has data');
      assert(localStorageServiceMock.hasData('test6'), 'LocalStorage with key test6 must has data');

      assert(localStorageServiceMock.read('test4') as String == 'test', 'LocalStorage with key test4 must has test');
      assert(localStorageServiceMock.read('test5') as bool == true, 'LocalStorage with key test5 must has true');
      assert(localStorageServiceMock.read('test6') as int == 12345, 'LocalStorage with key test6 must has 12345');
    });

    test('Tests over Get Storage Local Storage Service - nonexisting elements', () async {
      assert(!localStorageServiceMock.hasData('test7'), "LocalStorage with key test7 shouldn't have data");
      assert(!localStorageServiceMock.hasData('test8'), "LocalStorage with key test8 shouldn't have data");
      assert(!localStorageServiceMock.hasData('test9'), "LocalStorage with key test9 shouldn't have data");

      assert(localStorageServiceMock.read('test7') as dynamic == null, 'LocalStorage with key test7 must be null');
      assert(localStorageServiceMock.read('test8') as dynamic == null, 'LocalStorage with key test8 must be null');
      assert(localStorageServiceMock.read('test9') as dynamic == null, 'LocalStorage with key test9 must be null');
    });

    test('Tests over Get Storage Local Storage Service - nonexisting elements removing elements', () async {
      await localStorageServiceMock.write('test10', 'test');
      await localStorageServiceMock.write('test11', true);
      await localStorageServiceMock.write('test12', 12345);

      assert(localStorageServiceMock.hasData('test10'), 'LocalStorage with key test10 must has data');
      assert(localStorageServiceMock.hasData('test11'), 'LocalStorage with key test11 must has data');
      assert(localStorageServiceMock.hasData('test12'), 'LocalStorage with key test12 must has data');

      await localStorageServiceMock.remove('test10');
      await localStorageServiceMock.remove('test11');
      await localStorageServiceMock.remove('test12');

      assert(!localStorageServiceMock.hasData('test10'), "LocalStorage with key test10 shouldn't has data");
      assert(!localStorageServiceMock.hasData('test11'), "LocalStorage with key test11 shouldn't has data");
      assert(!localStorageServiceMock.hasData('test12'), "LocalStorage with key test12 shouldn't has data");

      assert(localStorageServiceMock.read('test10') as dynamic == null, 'LocalStorage with key test10 must be null');
      assert(localStorageServiceMock.read('test11') as dynamic == null, 'LocalStorage with key test11 must be null');
      assert(localStorageServiceMock.read('test12') as dynamic == null, 'LocalStorage with key test12 must be null');
    });
  });
}
