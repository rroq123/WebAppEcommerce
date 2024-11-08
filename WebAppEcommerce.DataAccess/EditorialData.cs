using Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class EditorialData : ICRUD<Editorial, int>
    {
        private readonly string _connectionString;

        public EditorialData(string connection)
        {

            _connectionString = connection;
        }

        public IEnumerable<Editorial> getAll()
        {
            List<Editorial> editoriales = new List<Editorial>();

            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using SqlCommand cmd = new SqlCommand("sp_SeleccionarTodasEditoriales", connection);
                cmd.CommandType = CommandType.StoredProcedure;
                using SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Editorial editorial = new Editorial
                    {
                        IdEditorial = Convert.ToInt32(reader["IdEditorial"]),
                        Nombre = Convert.ToString(reader["Nombre"])
                    };

                    editoriales.Add(editorial);
                }
            }
            return editoriales;
        }

        public Editorial getByID(int id)
        {
            throw new NotImplementedException();
        }

        public Editorial insert(Editorial entity)
        {
            throw new NotImplementedException();
        }

        public Editorial update(Editorial entity, int id)
        {
            throw new NotImplementedException();
        }
        public Editorial delete(int entity)
        {
            throw new NotImplementedException();
        }
    }
}
