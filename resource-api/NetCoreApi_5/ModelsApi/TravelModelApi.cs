using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NetCoreApi_5.ModelsApi
{
    public class TravelModelApi
    {

        public int Id_Tavel { get; set; }

        public DateTime? Time { get; set; }

        public int Id_User { get; set; }

        public int? Id_Road { get; set; }

    }
}
