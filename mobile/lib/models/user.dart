
class user
{
  int? Id_User;
  int? Id_Rol;
  String? Name;
  String? User_Name;
  String? Student_Code;
  String? Ident_Card;
  String? Password;

  ///Columns

  static const tblUser = 'User';
  static const colIdUser = 'Id_User';
  static const colIdRol = 'Id_Rol';
  static const colName = 'Name';
  static const colUserName = 'User_Name';
  static const colStudentCode = 'Student_Code';
  static const colIdentCard = 'Ident_Card';
  static const colPassword = 'Password';

  Map<String,dynamic> toMap()
  {
    var map = <String,dynamic>
    {
      'Id_User': Id_User,
      'Id_Rol': Id_Rol,
      'Name': Name,
      'User_Name': User_Name,
      'Student_Code': Student_Code,
      'Ident_Card': Ident_Card,
      'Password': Password,
    };
    if(Id_User != null)
    {
      map[colIdUser] = Id_User;
    }
    return map;
  }

  user.fromMap(Map<String,dynamic> map)
  {
    Id_User = map[colIdUser];
    Id_Rol = map[colIdRol];
    Name = map[colName];
    Student_Code = map[colStudentCode];
    Ident_Card = map[colIdentCard];
    Password = map[colPassword];
  }

  user.fromJson(Map<String,dynamic> json)
  {

  }

  user._();

  user
      (
        int Id_User,
        int Id_Rol,
        String Name,
        String User_Nam,
        String Student_Code,
        String Ident_Card,
        String Password,
      )
  {
    this.Id_User = Id_User;
    this.Id_Rol = Id_Rol;
    this.Name = Name;
    this.Student_Code = Student_Code;
    this.Ident_Card = Ident_Card;
    this.Password = Password;
  }

  static List<user> passList = [];
  static user pass = user._();
  static user ct = user._();
}