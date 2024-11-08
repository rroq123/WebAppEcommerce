using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Models
{
    public class Libro
    {
        public int IdLibro { get; set; }
        
        public string? ISBN { get; set; }
        
        public string? Nombre { get; set; }
        
        public int IdEditorial { get; set; }
        
        [Range(0, int.MaxValue)]
        public int AnioEdicion { get; set; }
        
        public int IdCategoria { get; set; }

        [Range(0, int.MaxValue)]
        public int Stock { get; set; }
        
        public string? Imagen { get; set; }
        
        public Editorial? Editorial { get; set; }
        
        public Categoria? Categoria { get; set; }
    }
}
