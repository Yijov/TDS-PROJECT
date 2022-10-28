using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class PositionModel
    {
        [Key]
        public int Id_Position { get; set; }

        [Column(TypeName = "Decimal(17,15)")]
        public double Lat { get; set; }

        [Column(TypeName = "Decimal(17,15)")]
        public double Log { get; set; }

        [Column(TypeName = "DateTime")]
        public DateTime? Time { get; set; }

        [Display(Name = "Travel")]
        public virtual int? Id_Travel { get; set; }

        [ForeignKey("Id_Travel")]
        public virtual TravelModel Users { get; set; }
    }
}
