import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quotes/data/app_database.dart';
import 'package:quotes/data/customer_repository.dart';

void main() {
  late AppDatabase database;
  late CustomerRepository repository;

  setUp(() {
    database = AppDatabase(executor: NativeDatabase.memory());
    repository = CustomerRepository(database);
  });

  tearDown(() async => database.close());

  test(
    'creates trimmed customer details and searches all contact fields',
    () async {
      final id = await repository.save(
        const CustomerDraft(
          name: '  Tendai Moyo  ',
          location: '  Chitungwiza ',
          phone: '  0772 123 456 ',
          notes: 'New borehole site',
        ),
      );
      final customer = await (database.select(
        database.customers,
      )..where((row) => row.id.equals(id))).getSingle();

      expect(customer.name, 'Tendai Moyo');
      expect(customer.location, 'Chitungwiza');
      expect(customer.phone, '0772 123 456');
      expect(
        await repository.watchCustomers(search: 'tendai').first,
        hasLength(1),
      );
      expect(
        await repository.watchCustomers(search: 'CHITUNG').first,
        hasLength(1),
      );
      expect(
        await repository.watchCustomers(search: '0772').first,
        hasLength(1),
      );
      expect(
        await repository.watchCustomers(search: 'borehole').first,
        hasLength(1),
      );
      expect(await repository.watchCustomers(search: 'Harare').first, isEmpty);
    },
  );

  test('edits customer and preserves id and creation time', () async {
    final id = await repository.save(const CustomerDraft(name: 'Old name'));
    final before = await (database.select(
      database.customers,
    )..where((row) => row.id.equals(id))).getSingle();
    await repository.save(
      const CustomerDraft(
        name: 'Updated name',
        location: 'Bulawayo',
        phone: '0712 000 000',
        notes: 'Call first',
      ),
      id: id,
    );
    final after = await (database.select(
      database.customers,
    )..where((row) => row.id.equals(id))).getSingle();

    expect(after.id, before.id);
    expect(after.createdAt, before.createdAt);
    expect(after.name, 'Updated name');
    expect(after.location, 'Bulawayo');
    expect(after.phone, '0712 000 000');
    expect(after.notes, 'Call first');
    expect(after.updatedAt.isBefore(before.updatedAt), isFalse);
  });

  test(
    'archives, hides, searches and restores without deleting customer',
    () async {
      final id = await repository.save(
        const CustomerDraft(name: 'Archived customer'),
      );
      await repository.setArchived(id, archived: true);

      expect(await repository.watchCustomers().first, isEmpty);
      expect(
        await repository.watchCustomers(search: 'archived').first,
        isEmpty,
      );
      expect(
        (await repository.watchCustomers(includeArchived: true).first)
            .single
            .isArchived,
        isTrue,
      );

      await repository.setArchived(id, archived: false);
      expect(
        (await repository.watchCustomers().first).single.name,
        'Archived customer',
      );
    },
  );

  test('rejects blank names and updates for missing customers', () async {
    await expectLater(
      repository.save(const CustomerDraft(name: '  ')),
      throwsArgumentError,
    );
    await expectLater(
      repository.save(const CustomerDraft(name: 'Missing'), id: 999),
      throwsStateError,
    );
  });
}
