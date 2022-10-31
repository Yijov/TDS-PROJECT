
class rol
{
  int? Id_Rol;
  String? Description;

  ///Columns
  static const tblRol = 'Rol';
  static const colIdRol = 'Id_Rol';
  static const colDescription = 'Description';

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>
    {
      'Description': Description,
    };
    if(Id_Rol != null)
    {
      map[colIdRol] = Id_Rol;
    }
    return map;
  }

  rol.fromMap(Map<String,dynamic> map)
  {
    Id_Rol = map[colIdRol];
    Description = map[colDescription];
  }

  rol.fromJson(Map<String,dynamic> json)
  {

  }

  rol._();

  rol
      (
        int Id_Rol,
        String Description,
      )
  {
    this.Id_Rol = Id_Rol;
    this.Description = Description;
  }

  static List<rol> passList = [];
  static rol pass = rol._();
  static rol ct = rol._();
}