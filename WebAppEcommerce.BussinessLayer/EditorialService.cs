using DataAccess;
using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebAppEcommerce.BussinessLayer
{
    public class EditorialService
    {
        private readonly EditorialData _editorialData;
        public EditorialService(string conn)
        {
            _editorialData = new EditorialData(conn);
        }

        public IEnumerable<Editorial> getAll()
        {
            return _editorialData.getAll();
        }
    }
}
