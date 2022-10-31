

class position_Travel
{
  int? Id_Position;
  int? Id_Travel;
  String? Location_Latitude;
  String? Location_Longitude;
  String? Time;

  ///Columns
  static const tblPositionTravel = 'Position_Travel';
  static const colIdPosition = 'Id_Position';
  static const colIdTravel = 'Id_Travel';
  static const colLocationLatitude = 'Location_Latitude';
  static const colLocationLongitude = 'Location_Longitude';
  static const colTime = 'Time';

  Map<String,dynamic> toMap()
  {

    var map = <String,dynamic>
    {
      'Id_Travel': Id_Travel,
      'Location_Latitude': Location_Latitude,
      'Location_Longitude': Location_Longitude,
      'Time': Time,
    };
    if(Id_Position != null)
    {
      map[colIdPosition] = Id_Position;
    }
    return map;
  }

  position_Travel.fromMap(Map<String,dynamic> map)
  {
    Id_Position = map[colIdPosition];
    Id_Travel = map[colIdTravel];
    Location_Latitude = map[colLocationLatitude];
    Location_Longitude = map[colLocationLongitude];
    Time = map[colTime];
  }

  position_Travel.fromJson(Map<String,dynamic> json)
  {

  }

  position_Travel._();

  static List<position_Travel> passList = [];
  static position_Travel pass = position_Travel._();
  static position_Travel ct = position_Travel._();

}