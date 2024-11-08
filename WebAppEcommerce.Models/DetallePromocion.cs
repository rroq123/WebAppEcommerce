using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class DetallePromocion
    {
        public int IdDetallePromocion { get; set; }
        public int IdPromocion { get; set; }
        public int IdLibro { get; set; }
        public Promocion? Promocion { get; set; }
        public Libro? Libro { get; set; }
    }

}
