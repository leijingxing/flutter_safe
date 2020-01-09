import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'safelist.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  final String tableName = "safe";
  final String name = "name";
  final String path = "path";
  final String times = "times";
  final String apppath = "apppath";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'safe.db');
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  //创建数据库表
  void _onCreate(Database db, int version) async {
    //初始化user
    await db.execute(
        "create table $tableName($path text primary key,$name text not null ,$apppath text not null ,"
            "times text not null)");
  }

//插入user
  Future<int> saveItemSafe(SafeList safeList) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", safeList.toMap());
    return res;
  }

  //查询
  Future<List> getTotalList() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ");
    return result.toList();
  }


  //获取Uid排序
  Future<List> getNewUid() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Msg group by uid order by times desc");
    return result.toList();
  }


  //查询总数
  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT COUNT(*) FROM $tableName"
    ));
  }

//按照id查询
  Future<SafeList> getItem(String  apppath) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE uid = $apppath");
    if (result.length>0){
      SafeList user = SafeList.fromMap(result.first);
      return user;
    }
    return null;
  }

  //清空数据
  Future<int> clear() async {
    var dbClient = await db;
    return await dbClient.delete(tableName);
  }

  //根据路径删除
  Future<int> deleteItem(String apppath) async {
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: "$apppath = ?", whereArgs: [apppath]
    );
  }

  //关闭
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}