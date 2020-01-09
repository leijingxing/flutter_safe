class SafeList{

  String name;
  String path;
  String times;
  String apppath;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['path'] = path;
    map['times'] = times;
    map['apppath'] = apppath;
    return map;
  }

  static SafeList fromMap(Map<String, dynamic> map) {
    SafeList user = new SafeList();
    user.name = map['name'];
    user.path = map['path'];
    user.times = map['times'];
    user.apppath = map['apppath'];
    return user;
  }
  static List<SafeList> fromMapList(dynamic mapList) {
    List<SafeList> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}