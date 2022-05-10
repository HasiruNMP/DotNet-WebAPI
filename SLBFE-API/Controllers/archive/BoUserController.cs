/*using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BoUserController : ControllerBase
    {

        private readonly IConfiguration _configuration;

        public BoUserController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        [HttpGet, Route("bologin")]
        public ActionResult UserLogin(String email, String password)
        {
            string query = @"SELECT Email
                      ,Password
                  FROM dbo.BO_USERS
                  Where Email ='" + email + "'  AND Password ='" + password + "'";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))

                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return Ok(table);
        }
    }
}
*/