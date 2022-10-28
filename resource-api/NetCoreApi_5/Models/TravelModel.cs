using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class TravelModel 
    {
        [Key]
        public int Id_Tavel { get; set; }

        [Column(TypeName = "DateTime")]
        public DateTime? Time { get; set; }

        [Column(TypeName = "int")]
        public int Id_User { get; set; }

        // Foreign key   
        /*[Display(Name = "User")]
        public virtual int? Id_User { get; set; }

        [ForeignKey("Id_User")]
        public virtual UserModel Users { get; set; }*/

        [Display(Name = "Road")]
        public virtual int? Id_Road { get; set; }

        [ForeignKey("Id_Road")]
        public virtual RoadModel Roads { get; set; }
    }
}
