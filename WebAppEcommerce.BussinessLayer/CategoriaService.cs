using DataAccess;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebAppEcommerce.DataAccess;

namespace WebAppEcommerce.BussinessLayer
{
    public class CategoriaService
    {
        private readonly CategoriaData _categoriaData;
        public CategoriaService(string conn)
        {
            _categoriaData = new CategoriaData(conn);
        }

        public IEnumerable<Categoria> getAll()
        {
            return _categoriaData.getAll();
        }
    }
}
