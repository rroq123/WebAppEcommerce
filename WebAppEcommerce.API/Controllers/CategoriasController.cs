using Microsoft.AspNetCore.Mvc;
using Models;
using WebAppEcommerce.BussinessLayer;

namespace WebAppEcommerce.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriasController : Controller
    {
        private readonly CategoriaService _CategoriaService;

        public CategoriasController(CategoriaService CategoriaService)
        {
            _CategoriaService = CategoriaService;
        }


        [HttpGet]
        public IEnumerable<Categoria> Get()
        {
            return _CategoriaService.getAll();
        }
    }
}
