

class travel
{
  int? Id_Travel;
  int? Id_User;
  int? Id_Road;
  String? Time;

  ///Columns
  static const tblTravel = 'Travel';
  static const colIdTravel = 'Id_Travel';
  static const colIdUser = 'Id_User';
  static const colIdRoad = 'Id_Road';
  static const colTime = 'Time';

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>
    {
      'Id_User': Id_User,
      'Id_Road': Id_Road,
      'Time': Time,
    };
    if(Id_Travel != null)
    {
      map[colIdTravel] = Id_Travel;
    }
    return map;
  }

  travel.fromMap(Map<String,dynamic> map)
  {
    Id_Travel = map[colIdTravel];
    Id_User = map[colIdUser];
    Id_Road = map[colIdRoad];
    Time = map[colTime];
  }

  travel.fromJson(Map<String,dynamic> json)
  {

  }

  travel._();

  static List<travel> passList = [];
  static travel pass = travel._();
  static travel ct = travel._();
}