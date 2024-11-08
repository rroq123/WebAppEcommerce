using DataAccess;
using Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebAppEcommerce.DataAccess
{
    public class CategoriaData : ICRUD<Categoria, int>
    {
        private readonly string _connectionString;

        public CategoriaData(string connection)
        {

            _connectionString = connection;
        }


        public IEnumerable<Categoria> getAll()
        {
            List<Categoria> categorias = new List<Categoria>();

            using (SqlConnection connection = new(_connectionString))
            {
                connection.Open();
                using SqlCommand cmd = new SqlCommand("sp_SeleccionarTodasCategorias", connection);
                cmd.CommandType = CommandType.StoredProcedure;
                using SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Categoria categoria = new Categoria
                    {
                        IdCategoria = Convert.ToInt32(reader["IdCategoria"]),
                        Nombre = Convert.ToString(reader["Nombre"]),
                        Descripcion = Convert.ToString(reader["Descripcion"])
                    };

                    categorias.Add(categoria);
                }
            }
            return categorias;
        }

        public Categoria getByID(int id)
        {
            throw new NotImplementedException();
        }

        public Categoria insert(Categoria entity)
        {
            throw new NotImplementedException();
        }

        public Categoria update(Categoria entity, int id)
        {
            throw new NotImplementedException();
        }

        public Categoria delete(int entity)
        {
            throw new NotImplementedException();
        }
    }
}
