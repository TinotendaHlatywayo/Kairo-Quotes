import 'package:drift/drift.dart';

import 'app_database.dart';

class CustomerDraft {
  const CustomerDraft({
    required this.name,
    this.location = '',
    this.phone = '',
    this.notes = '',
  });

  final String name;
  final String location;
  final String phone;
  final String notes;
}

class CustomerRepository {
  const CustomerRepository(this._database);

  final AppDatabase _database;

  Stream<List<CustomerData>> watchCustomers({
    String search = '',
    bool includeArchived = false,
  }) {
    return (_database.select(_database.customers)..orderBy([
          (row) => OrderingTerm(expression: row.name.lower()),
          (row) => OrderingTerm(expression: row.id),
        ]))
        .watch()
        .map((rows) {
          final query = search.trim().toLowerCase();
          return rows
              .where((row) {
                if (!includeArchived && row.isArchived) return false;
                if (query.isEmpty) return true;
                return row.name.toLowerCase().contains(query) ||
                    row.location.toLowerCase().contains(query) ||
                    row.phone.toLowerCase().contains(query) ||
                    row.notes.toLowerCase().contains(query);
              })
              .toList(growable: false);
        });
  }

  Future<int> save(CustomerDraft draft, {int? id}) async {
    final name = draft.name.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(draft.name, 'name', 'Required.');
    }

    final now = DateTime.now();
    if (id == null) {
      return _database
          .into(_database.customers)
          .insert(
            CustomersCompanion.insert(
              name: name,
              location: Value(draft.location.trim()),
              phone: Value(draft.phone.trim()),
              notes: Value(draft.notes.trim()),
              createdAt: Value(now),
              updatedAt: Value(now),
            ),
          );
    }

    final changed =
        await (_database.update(
          _database.customers,
        )..where((row) => row.id.equals(id))).write(
          CustomersCompanion(
            name: Value(name),
            location: Value(draft.location.trim()),
            phone: Value(draft.phone.trim()),
            notes: Value(draft.notes.trim()),
            updatedAt: Value(now),
          ),
        );
    if (changed == 0) throw StateError('Customer $id no longer exists.');
    return id;
  }

  Future<void> setArchived(int id, {required bool archived}) async {
    final changed =
        await (_database.update(
          _database.customers,
        )..where((row) => row.id.equals(id))).write(
          CustomersCompanion(
            isArchived: Value(archived),
            updatedAt: Value(DateTime.now()),
          ),
        );
    if (changed == 0) throw StateError('Customer $id no longer exists.');
  }
}
