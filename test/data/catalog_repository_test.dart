import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/catalog_repository.dart';

void main() {
  late AppDatabase database;
  late CatalogRepository repository;

  setUp(() {
    database = AppDatabase(executor: NativeDatabase.memory());
    repository = CatalogRepository(database);
  });

  tearDown(() async => database.close());

  test(
    'creates and edits sections and items with currency-aware blank prices',
    () async {
      final sectionId = await repository.addSection('DRILLING');
      final itemId = await repository.saveItem(
        CatalogDraft(
          designation: 'Borehole drilling',
          unit: 'metre',
          sectionId: sectionId,
        ),
      );
      var item = await (database.select(
        database.catalogItems,
      )..where((row) => row.id.equals(itemId))).getSingle();
      expect(item.isSection, isFalse);
      expect(item.defaultUnitPriceMinor, isNull);
      expect(item.defaultPriceCurrencyCode, 'USD');
      expect(item.unit, 'metre');

      await repository.saveSection('BOREHOLE WORK', id: sectionId);
      await repository.saveItem(
        CatalogDraft(
          designation: 'Borehole drilling (revised)',
          unit: 'm',
          defaultUnitPriceMinor: 12550,
          defaultPriceCurrencyCode: 'ZiG',
          sectionId: sectionId,
        ),
        id: itemId,
      );

      item = await (database.select(
        database.catalogItems,
      )..where((row) => row.id.equals(itemId))).getSingle();
      expect(item.designation, 'Borehole drilling (revised)');
      expect(item.unit, 'm');
      expect(item.defaultUnitPriceMinor, 12550);
      expect(item.defaultPriceCurrencyCode, 'ZiG');
      expect(
        (await repository.watchItems().first).first.designation,
        'BOREHOLE WORK',
      );
    },
  );

  test(
    'archives and restores items and hides children of archived sections',
    () async {
      final sectionId = await repository.addSection('Survey');
      final itemId = await repository.saveItem(
        CatalogDraft(designation: 'Geophysical survey', sectionId: sectionId),
      );
      await repository.setArchived(itemId, archived: true);
      expect((await repository.watchItems().first).map((row) => row.id), [
        sectionId,
      ]);
      expect(
        (await repository.watchItems(includeArchived: true).first)
            .singleWhere((row) => row.id == itemId)
            .isArchived,
        isTrue,
      );
      await repository.setArchived(itemId, archived: false);
      expect((await repository.watchItems().first).map((row) => row.id), [
        sectionId,
        itemId,
      ]);

      await repository.setArchived(sectionId, archived: true);
      expect(await repository.watchItems().first, isEmpty);
      expect(
        await repository.watchItems(includeArchived: true).first,
        hasLength(2),
      );
      await repository.setArchived(sectionId, archived: false);
      expect(await repository.watchItems().first, hasLength(2));
    },
  );

  test(
    'reorders sections and items without changing their hierarchy',
    () async {
      final firstSection = await repository.addSection('First');
      final secondSection = await repository.addSection('Second');
      final firstItem = await repository.saveItem(
        CatalogDraft(designation: 'First item', sectionId: firstSection),
      );
      final secondItem = await repository.saveItem(
        CatalogDraft(designation: 'Second item', sectionId: firstSection),
      );
      await repository.reorder(secondSection, newIndex: 0);
      await repository.reorder(secondItem, newIndex: 0);

      final visible = await repository.watchItems().first;
      expect(
        visible.where((row) => row.isSection).map((row) => row.id),
        [secondSection, firstSection],
      );
      expect(
        visible
            .where((row) => row.sectionId == firstSection)
            .map((row) => row.id),
        [secondItem, firstItem],
      );
      expect(
        (await database.select(database.catalogItems).get())
            .singleWhere((row) => row.id == secondItem)
            .sectionId,
        firstSection,
      );
    },
  );

  test('rejects invalid descriptions, prices, sections and updates', () async {
    final sectionId = await repository.addSection('Archived section');
    await repository.setArchived(sectionId, archived: true);
    await expectLater(repository.addSection('  '), throwsArgumentError);
    await expectLater(
      repository.saveItem(const CatalogDraft(designation: '  ')),
      throwsArgumentError,
    );
    await expectLater(
      repository.saveItem(
        const CatalogDraft(designation: 'Bad price', defaultUnitPriceMinor: -1),
      ),
      throwsRangeError,
    );
    await expectLater(
      repository.saveItem(
        CatalogDraft(designation: 'Bad section', sectionId: sectionId),
      ),
      throwsArgumentError,
    );
    await expectLater(
      repository.saveItem(const CatalogDraft(designation: 'Missing'), id: 999),
      throwsStateError,
    );
    await expectLater(
      repository.saveSection('Missing', id: 999),
      throwsStateError,
    );
    await expectLater(
      repository.setArchived(999, archived: true),
      throwsStateError,
    );
  });
}
