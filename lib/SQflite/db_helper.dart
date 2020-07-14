import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'Employee.dart';
class DbHelper
{
  static Database database;
  static const String ID='id';
  static const String NAME='name';
  static const String TABLE='Employee';
  static const String DBNAME='employee.db';
  Future<Database> get db async{
    if(database!=null)
    {
      return database;
    }
    database=await initDb();
    return database;
  }
  initDb() async{
    io.Directory directory=await getApplicationSupportDirectory();
    String path=join(directory.path,DBNAME);
    var db=await openDatabase(path,version: 1,onCreate: onCreate);
    return db;
  }
  onCreate(Database db,int version) async
  {
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,$NAME TEXT)");
  }
 Future<Employee> save(Employee employee) async
 {
   var dbClient=await db;
   employee.id=await dbClient.insert(TABLE, employee.toMap());
   return employee;
 } 
  Future<List<Employee>> getEmployee() async{
    var dbClient=await db;
    List<Map> maps=await dbClient.query(TABLE,columns: [ID,NAME]);
    List<Employee> employees=[];
    if(maps.length>0)
    {
      for(int i=0;i<maps.length;i++)
      {
        employees.add(Employee.fromMap(maps[i]));
      }
    }
    return employees;
  }
  Future<int> delete(int id) async{
    var dbClient=await db;
    return await dbClient.delete(TABLE,where: '$ID=?',whereArgs: [id]);
  }
  Future<int> update(Employee employee) async{
    var dbClient=await db;
    return await dbClient.update(TABLE,employee.toMap(),where:'$ID=?',whereArgs: [employee.id]);
  }
  Future close() async{
    var dbClient=await db;
    dbClient.close();
  }
} 