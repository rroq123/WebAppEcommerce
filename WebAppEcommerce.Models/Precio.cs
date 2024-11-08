using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Precio
    {
        public int IdPrecio { get; set; }
        public int IdLibro { get; set; }
        public float Costo { get; set; }
        public DateTime Fecha { get; set; }
        public Libro? Libro { get; set; }
    }
}
