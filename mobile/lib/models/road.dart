

class road
{
  int? Id_Road;
  int? Id_User;
  String? Description;
  String? Schedule;

  ///Columns
  static const tblRoad = 'Road';
  static const colIdRoad = 'Id_Road';
  static const colIdUser = 'Id_User';
  static const colDescription = 'Description';
  static const colSchedule = 'Schedule';

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>
    {
      'Id_User': Id_User,
      'Description': Description,
      'Schedule': Schedule,
    };
    if(Id_Road != null)
    {
      map[colIdRoad] = Id_Road;
    }
    return map;
  }

  road.fromMap(Map<String,dynamic> map)
  {
    Id_Road = map[colIdRoad];
    Id_User = map[colIdUser];
    Description = map[colDescription];
    Schedule = map[colSchedule];
  }

  road._();

  road
      (
          int Id_Road,
          int? Id_User,
          String Description,
          String Schedule,
      )
  {
    this.Id_Road = Id_Road;
    this.Id_User = Id_User;
    this.Description = Description;
    this.Schedule = Schedule;
  }

  static List<road> passList = [];
  static road pass = road._();
  static road ct = road._();

}