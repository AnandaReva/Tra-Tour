import 'package:mysql1/mysql1.dart';



/* class Mysql {
  static String host = '192.168.1.5';
  static String user = 'root';
  static String password = 'password';
  static String db = 'sampah';
  static int port = 3306;

  static MySqlConnection? _connection;

  static Future<void> connect() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
    //  password: password,
      db: db,
    );
    try {
      _connection = await MySqlConnection.connect(settings);
    } catch (e) {
      print('Error connecting to MySQL: $e');
    }
  }

  static MySqlConnection get connection {
    if (_connection == null) {
      throw Exception(
          'Connection has not been initialized. Call connect() method first.');
    }
    return _connection!;
  }

  static Future<void> close() async {
    try {
      if (_connection != null) {
        await _connection!.close();
        _connection = null; // Reset connection after closing
      }
    } catch (e) {
      print('Error closing MySQL connection: $e');
    }
  }
}
 */
/* contoh pemakainan:
 try {
  await Mysql.connect();
  var results = await Mysql.connection.query('SELECT * FROM table_name');
  for (var row in results) {
    print(row);
  }
} catch (e) {
  print('Error: $e');
} finally {
  await Mysql.close();
} */