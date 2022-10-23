using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.ModelsApi
{
    public class RoadModelApi
    {
        public int Id_Road { get; set; }

        public string? Description { get; set; }

        public DateTime? Time { get; set; }

        public int Id_User { get; set; }
    }
}
