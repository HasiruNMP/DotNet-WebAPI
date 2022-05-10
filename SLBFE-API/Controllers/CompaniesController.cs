using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SLBFE_API.Models;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    [Route("api/companies")]
    [ApiController]
    public class CompaniesController : ControllerBase
    {

        private readonly IConfiguration _configuration;

        public CompaniesController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Register a new foriegn company user
        /// </summary>
        /// /// <response code="400"></response>
        [HttpPost, Route("register")]
        //[Authorize(Roles = "FC")]
        public JsonResult PostUser(FcUser user)
        {
            string query = @"insert into dbo.FC_USERS values(@Email,@Name,@CompanyName)";
            string query2 = @"insert into dbo.USER_AUTH values(@UserID,@Password,'FC')";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@Email", user.Email);
                    myCommand.Parameters.AddWithValue("@Name", user.Name);
                    myCommand.Parameters.AddWithValue("@CompanyName", user.CompanyName);
                  

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                 

                }

                using (SqlCommand myCommand = new SqlCommand(query2, myCon))
                {

                    myCommand.Parameters.AddWithValue("@UserID", user.Email);
                    myCommand.Parameters.AddWithValue("@Password", user.Password);
           


                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();


                }
            }
            return new JsonResult("Registered Successfully!");
        }

/*        [HttpGet, Route("fclogin")]
        public ActionResult UserLogin(String email, String password)
        {
            string query = @"SELECT Email
                      ,Password
                  FROM dbo.FC_USERS
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
        }*/

    }
}
