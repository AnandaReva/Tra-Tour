import 'package:mysql1/mysql1.dart';

class Mysql {
  // String host = '192.168.1.6',
 static String host = '10.4.159.92', user = 'root', password = '', db = 'sampah';
  static int port = 3306;

  static Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );

    return await MySqlConnection.connect(settings);
  }
}
