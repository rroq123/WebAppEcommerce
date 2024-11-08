using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public interface ICRUD<T, ID>
    {
        T getByID(ID id);
        IEnumerable<T> getAll();
        T insert(T entity);
        T update(T entity, ID id);
        T delete(ID entity);
    }
}
