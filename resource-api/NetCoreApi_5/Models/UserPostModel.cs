using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class UserPostModel
    {

        public string? Name { get; set; }
        
        public string? User_Name { get; set; }

        public string? Student_Code { get; set; }

        public string? Ident_Card { get; set; }

        public string? Password { get; set; }

        public virtual int? Id_Rol { get; set; }

    }
}
