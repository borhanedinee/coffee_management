// lib/data/datasources/database_helper.dart
import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  // Private constructor for singleton pattern
  DatabaseHelper._internal();

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'coffee_shop.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create tables when DB is first initialized
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        startQuantity INTEGER NULL,
        endQuantity INTEGER NULL
      )
    ''');
    // Create sessions table
    await db.execute('''
      CREATE TABLE sessions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        priceInCaisse REAL NOT NULL,
        priceCalculatedByApp REAL NOT NULL,
        sessionDate TEXT,
        period TEXT NOT NULL,
        status TEXT NOT NULL,
        toleranceValue REAL NOT NULL
      )
    ''');
  }

  // Insert a product
  Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert('products', product,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  // Update a product
  Future<int> updateProduct(int id, Map<String, dynamic> product) async {
    final db = await database;
    return await db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete a product
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // New search function
  Future<List<Map<String, dynamic>>> searchProductsByName(String query) async {
    final db = await database;
    return await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'], // Case-insensitive partial match
    );
  }

  // New function to update startQuantity
  Future<int> updateProductStartQuantity(int id, int? startQuantity) async {
    final db = await database;
    return await db.update(
      'products',
      {'startQuantity': startQuantity}, // Null is valid in SQLite for INTEGER
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // New function to fetch products with non-null startQuantity
  Future<List<Map<String, dynamic>>> getProductsThatHasStartQuantity() async {
    try {
      final db = await database;
      return await db.query(
        'products',
        where: 'startQuantity IS NOT NULL',
      );
    } catch (e) {
      print('Error fetching products with start quantity: $e');
      rethrow;
    }
  }

  // New function to update endQuantity
  Future<int> updateProductEndQuantity(int id, int? endQuantity) async {
    try {
      final db = await database;
      return await db.update(
        'products',
        {'endQuantity': endQuantity}, // Null is valid for INTEGER
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating product end quantity: $e');
      rethrow;
    }
  }

  // SESSIONS
  // Fetch all sessions
  Future<List<Map<String, Object?>>> fetchSessions({
    DateTime? dateFilter,
    String? statusFilter,
  }) async {
    final db = await database;

    String? whereClause;
    List<dynamic> whereArgs = [];

    if (dateFilter != null) {
      final dateStr =
          DateTime(dateFilter.year, dateFilter.month, dateFilter.day)
              .toIso8601String()
              .substring(0, 10);
      whereClause = "DATE(sessionDate) = ?";
      whereArgs.add(dateStr);
    }

    if (statusFilter != null) {
      whereClause =
          whereClause == null ? 'status = ?' : '$whereClause AND status = ?';
      whereArgs.add(statusFilter);
    }

    // Fetch all sessions with the applied filters
    final sessionMaps = await db.query(
      'sessions',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'sessionDate DESC', // Sort by date descending
    );

    return sessionMaps;
  }

  // Add a session
  Future<int> addSession(SessionModel session) async {
    final db = await database;
    return await db.insert(
      'sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete a session by ID
  Future<int> deleteSession(int sessionID) async {
    final db = await database;
    return await db.delete(
      'sessions',
      where: 'id = ?',
      whereArgs: [sessionID],
    );
  }

  // Clear start quantities for all products
  Future<void> clearStartAndEndQuantities() async {
    final db = await database;
    await db.update(
      'products',
      {
        'startQuantity': null,
        'endQuantity': null,
      }, // Set startQuantity to null
    );
  }

  // Close the database (optional, for cleanup)
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
