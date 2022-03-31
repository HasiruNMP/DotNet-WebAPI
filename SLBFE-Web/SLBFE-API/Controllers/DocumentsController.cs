using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SLBFE_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DocumentsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public DocumentsController(IConfiguration configuration,IWebHostEnvironment webHostEnvironment)
        {
            _configuration = configuration;
            _webHostEnvironment = webHostEnvironment;
        }

        [HttpPut,Route("savefile")]
        public ActionResult SaveFile(string fileType)
        {
            try
            {
                var httpRequest = Request.Form;
                var postedFile = httpRequest.Files[0];
                string filename = postedFile.FileName;
                var physicalPath = _webHostEnvironment.ContentRootPath + "/FileStorage/" + filename;

                using(var stream = new FileStream(physicalPath, FileMode.Create))
                {
                    postedFile.CopyTo(stream);
                }

                return Ok("File Uploaded");
            }
            catch (Exception ex)
            {
                return Ok(ex);
            }
        }
    }
}
