using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace SLBFE_API.Controllers
{
    [Route("api/files")]
    [ApiController]
    public class FilesController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IWebHostEnvironment _webHostEnvironment;
        public FilesController(IConfiguration configuration, IWebHostEnvironment webHostEnvironment)
        {
            _configuration = configuration;
            _webHostEnvironment = webHostEnvironment;
        }

        /// <summary>
        /// Uploads a specific type of a document of a specific user
        /// </summary>
        /// /// <response code="400">If there's an error saving the document</response>
        [HttpPut, Route("{NIC}/documents/{documentType}/upload")]
        //[Authorize(Roles = "JS")]
        public ActionResult SaveDocument(int NIC, string documentType)
        {
            try
            {
                var httpRequest = Request.Form;
                var postedFile = httpRequest.Files[0];
                string filename = postedFile.FileName;
                var physicalPath = _webHostEnvironment.ContentRootPath + $"/FileStorage/JobSeekers/Documents/{NIC}/{NIC}" + filename;

                using (var stream = new FileStream(physicalPath, FileMode.Create))
                {
                    postedFile.CopyTo(stream);
                }

                return Ok("Document Uploaded Succesfully");
            }
            catch (Exception ex)
            {
                return BadRequest("Error Saving Document!");
            }
        }

        /// <summary>
        /// Downloads a specific type of a document of a specific user
        /// </summary>
        /// /// <response code="404">If the document cannot be found</response>
        [HttpGet, Route("{NIC}/documents/{documentType}/download")]
        //[Authorize(Roles = "BO,JS")]
        public async Task<ActionResult> DownloadFile(int NIC, string documentType)
        {
            try
            {
                var filePath = _webHostEnvironment.ContentRootPath + $"/FileStorage/JobSeekers/Documents/{NIC}/{NIC}{documentType}.pdf";
                var bytes = await System.IO.File.ReadAllBytesAsync(filePath);
                return File(bytes, "text/plain", Path.GetFileName(filePath));
            }
            catch (Exception ex)
            {
                return NotFound("Document Not Found!");
            }
        }

        /// <summary>
        /// Uploads the profile picture of a specific user
        /// </summary>
        /// /// <response code="400">If there's an error saving the photo</response>
        [HttpPut, Route("{NIC}/images/propic/upload")]
        //[Authorize(Roles = "JS")]
        public ActionResult UploadProPic(int NIC)
        {
            try
            {
                var httpRequest = Request.Form;
                var postedFile = httpRequest.Files[0];
                string filename = postedFile.FileName;
                var physicalPath = _webHostEnvironment.ContentRootPath + $"/FileStorage/JobSeekers/ProfilePictures/{NIC}pp.jpg";

                using (var stream = new FileStream(physicalPath, FileMode.Create))
                {
                    postedFile.CopyTo(stream);
                }

                return Ok("Photo Uploaded Succesfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }
        }

        /// <summary>
        /// Downloads the profile picture of a specific user
        /// </summary>
        /// /// <response code="404">If the image cannot be found</response>   
        [HttpGet, Route("{NIC}/images/propic/download")]
        public async Task<ActionResult> DownloadProfilePicture(int NIC)
        {
            try
            {
                var filePath = _webHostEnvironment.ContentRootPath + $"/FileStorage/JobSeekers/ProfilePictures/{NIC}pp.jpg";
                var bytes = await System.IO.File.ReadAllBytesAsync(filePath);
                return File(bytes, "text/plain", Path.GetFileName(filePath));
            }
            catch (Exception ex)
            {
                return NotFound("Image Not Found!");
            }
        }

        /// <summary>
        /// Downloads the SLBFE logo image
        /// </summary>
        [HttpGet("slbfe/logo")]
        public async Task<ActionResult> Logo()
        {
            try
            {
                var filePath = _webHostEnvironment.ContentRootPath + $"/FileStorage/SLBFE/logo.png";
                var bytes = await System.IO.File.ReadAllBytesAsync(filePath);
                return File(bytes, "image/png", Path.GetFileName(filePath));
            }
            catch(Exception ex)
            {
                return BadRequest(ex);
            }
        }


    }
}
