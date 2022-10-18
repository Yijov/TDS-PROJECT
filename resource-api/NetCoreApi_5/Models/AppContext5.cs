using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.Models
{
    public class AppContext5 : IdentityDbContext
    {
        public AppContext5(DbContextOptions options) : base(options)
        {
                
        }

        public DbSet<UserModel> UserModel { get; set; }
        public DbSet<RolModel> RolTblModel { get; set; }
        public DbSet<RoadModel> RoadModel { get; set; }
        public DbSet<PositionModel> PositionModel { get; set; }
        public DbSet<TravelModel> TravelModel { get; set; }
    }
}
