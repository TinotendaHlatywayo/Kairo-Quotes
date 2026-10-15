import 'package:drift/drift.dart';

import 'app_database.dart';

class CatalogDraft {
  const CatalogDraft({
    required this.designation,
    this.unit = '',
    this.defaultUnitPriceMinor,
    this.costPriceMinor,
    this.defaultPriceCurrencyCode = 'USD',
    this.sectionId,
  });

  final String designation;
  final String unit;
  final int? defaultUnitPriceMinor;
  final int? costPriceMinor;
  final String defaultPriceCurrencyCode;
  final int? sectionId;
}

class CatalogRepository {
  const CatalogRepository(this._database);

  final AppDatabase _database;

  Stream<List<CatalogItemData>> watchItems({bool includeArchived = false}) {
    return (_database.select(_database.catalogItems)..orderBy([
          (row) => OrderingTerm(expression: row.sortOrder),
          (row) => OrderingTerm(expression: row.id),
        ]))
        .watch()
        .asyncMap((rows) async {
          if (includeArchived) return rows;
          final byId = {for (final row in rows) row.id: row};
          return rows
              .where((row) {
                if (row.isArchived) return false;
                if (row.isSection || row.sectionId == null) return true;
                return byId[row.sectionId]?.isArchived != true;
              })
              .toList(growable: false);
        });
  }

  Future<int> addSection(String designation) async {
    final name = designation.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(designation, 'designation', 'Required.');
    }
    final sections = await (_database.select(
      _database.catalogItems,
    )..where((row) => row.isSection.equals(true))).get();
    final nextOrder = sections.fold<int>(
      0,
      (max, row) => row.sortOrder >= max ? row.sortOrder + 1 : max,
    );
    return _database
        .into(_database.catalogItems)
        .insert(
          CatalogItemsCompanion.insert(
            designation: name,
            isSection: const Value(true),
            sortOrder: Value(nextOrder),
          ),
        );
  }

  Future<int> saveItem(CatalogDraft draft, {int? id}) async {
    final name = draft.designation.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(draft.designation, 'designation', 'Required.');
    }
    if (draft.defaultUnitPriceMinor != null &&
        draft.defaultUnitPriceMinor! < 0) {
      throw RangeError.value(
        draft.defaultUnitPriceMinor!,
        'defaultUnitPriceMinor',
      );
    }
    if (draft.costPriceMinor != null && draft.costPriceMinor! < 0) {
      throw RangeError.value(draft.costPriceMinor!, 'costPriceMinor');
    }
    if (draft.sectionId != null) {
      final section =
          await (_database.select(_database.catalogItems)..where(
                (row) =>
                    row.id.equals(draft.sectionId!) &
                    row.isSection.equals(true),
              ))
              .getSingleOrNull();
      if (section == null || section.isArchived) {
        throw ArgumentError('Choose an active catalog section.');
      }
    }

    if (id == null) {
      final current = await _database.select(_database.catalogItems).get();
      final nextOrder = current.fold<int>(
        0,
        (max, row) => row.sortOrder >= max ? row.sortOrder + 1 : max,
      );
      return _database
          .into(_database.catalogItems)
          .insert(
            CatalogItemsCompanion.insert(
              designation: name,
              unit: Value(draft.unit.trim()),
              defaultUnitPriceMinor: Value(draft.defaultUnitPriceMinor),
              costPriceMinor: Value(draft.costPriceMinor),
              defaultPriceCurrencyCode: Value(draft.defaultPriceCurrencyCode),
              sectionId: Value(draft.sectionId),
              sortOrder: Value(nextOrder),
            ),
          );
    }

    final changed =
        await (_database.update(_database.catalogItems)
              ..where((row) => row.id.equals(id) & row.isSection.equals(false)))
            .write(
              CatalogItemsCompanion(
                designation: Value(name),
                unit: Value(draft.unit.trim()),
                defaultUnitPriceMinor: Value(draft.defaultUnitPriceMinor),
                costPriceMinor: Value(draft.costPriceMinor),
                defaultPriceCurrencyCode: Value(draft.defaultPriceCurrencyCode),
                sectionId: Value(draft.sectionId),
              ),
            );
    if (changed == 0) throw StateError('Catalog item $id no longer exists.');
    return id;
  }

  Future<int> saveSection(String designation, {required int id}) async {
    final name = designation.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(designation, 'designation', 'Required.');
    }
    final changed =
        await (_database.update(_database.catalogItems)
              ..where((row) => row.id.equals(id) & row.isSection.equals(true)))
            .write(CatalogItemsCompanion(designation: Value(name)));
    if (changed == 0) throw StateError('Catalog section $id no longer exists.');
    return id;
  }

  Future<void> setArchived(int id, {required bool archived}) async {
    final changed =
        await (_database.update(_database.catalogItems)
              ..where((row) => row.id.equals(id)))
            .write(CatalogItemsCompanion(isArchived: Value(archived)));
    if (changed == 0) throw StateError('Catalog entry $id no longer exists.');
  }

  Future<void> reorder(int id, {required int newIndex}) async {
    await _database.transaction(() async {
      final entry = await (_database.select(
        _database.catalogItems,
      )..where((row) => row.id.equals(id))).getSingleOrNull();
      if (entry == null) {
        throw StateError('Catalog entry $id no longer exists.');
      }
      final siblings =
          await (_database.select(_database.catalogItems)..where(
                (row) =>
                    row.isSection.equals(entry.isSection) &
                    (entry.sectionId == null
                        ? row.sectionId.isNull()
                        : row.sectionId.equals(entry.sectionId!)),
              ))
              .get();
      siblings.sort((a, b) {
        final byOrder = a.sortOrder.compareTo(b.sortOrder);
        return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
      });
      final currentIndex = siblings.indexWhere((row) => row.id == id);
      if (currentIndex < 0) {
        throw StateError('Catalog entry $id has no siblings.');
      }
      final targetIndex = newIndex.clamp(0, siblings.length - 1);
      if (targetIndex == currentIndex) return;
      final moved = siblings.removeAt(currentIndex);
      siblings.insert(targetIndex, moved);
      for (var index = 0; index < siblings.length; index++) {
        await (_database.update(_database.catalogItems)
              ..where((row) => row.id.equals(siblings[index].id)))
            .write(CatalogItemsCompanion(sortOrder: Value(index)));
      }
    });
  }
}
