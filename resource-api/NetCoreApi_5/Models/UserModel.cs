using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class UserModel : IdentityUser
    {
   

        [Column(TypeName = "nvarchar(150)")]
        public string? Name { get; set; }

        [Column(TypeName = "nvarchar(150)")]
        public string? User_Name { get; set; }

        [Column(TypeName = "nvarchar(150)")]
        public string? Student_Code { get; set; }

        [Column(TypeName = "nvarchar(150)")]
        public string? Ident_Card { get; set; }

        [Column(TypeName = "nvarchar(150)")]
        public string? Password { get; set; }

        // Foreign key   
        [Display(Name = "Rol")]
        public virtual int? Id_Rol { get; set; }

        [ForeignKey("Id_Rol")]
        public virtual RolModel Rols { get; set; }
    }
}
