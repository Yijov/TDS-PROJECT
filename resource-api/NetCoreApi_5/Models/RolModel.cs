using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class RolModel 
    {
        [Key]
        public int Id_Rol { get; set; }

        [Column(TypeName = "nvarchar(150)")]
        public string? Description { get; set; }
    }
}
