using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Distrito
    {
        public int IdDistrito { get; set; }
        public int IdProvincia { get; set; }
        public string? Nombre { get; set; }
        public Provincia? Provincia { get; set; }
    }
}
