using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.ModelsApi
{
    public class PositionModelApi
    {
        public int Id_Position { get; set; }

        public double Lat { get; set; }

        public double Log { get; set; }

        public DateTime? Time { get; set; }

        public int? Id_Travel { get; set; }
    }
}
