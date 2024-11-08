using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Provincia
    {
        public int IdProvincia { get; set; }
        public int IdDepartamento { get; set; }
        public string? Nombre { get; set; }

        public Departamento? Departamento { get; set; }
        public ICollection<Distrito>? Distritos { get; set; }
    }
}
