using Microsoft.AspNetCore.Mvc;
using Models;
using WebAppEcommerce.BussinessLayer;

namespace WebAppEcommerce.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EditorialesController : Controller
    {

        private readonly EditorialService _editorialService;

        public EditorialesController(EditorialService editorialService)
        {
            _editorialService = editorialService;
        }


        [HttpGet]
        public IEnumerable<Editorial> Get()
        {
            return _editorialService.getAll();
        }
    }
}
