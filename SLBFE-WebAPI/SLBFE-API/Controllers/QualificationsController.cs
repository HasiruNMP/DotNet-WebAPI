using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    //[Route("api/[controller]")]
    [ApiController]
    public class QualificationsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public QualificationsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet, Route("searchbyqualifications")]
        public ActionResult SearchByQualifications(bool o, bool a, bool h, string f)
        {
            string query = @"SELECT [NIC]
                      ,[Email]
                      ,[FirstName]
                      ,[LastName]
                      ,[DOB]
                      ,[Address]
                      ,[Profession]
                      ,[Affiliation]
                      ,[Gender]
                      ,[Nationality]
                      ,[MaritalStatus]
                      ,[Validity]
                      ,[PrimaryPhone]
                      ,[QualificationID]
                      ,[JS_NIC]
                      ,[OLStatus]
                      ,[ALStatus]
                      ,[DegreeStatus]
                      ,[DegreeField]
                  FROM [dbo].[JS_USERS JS_QUALIFICATIONS]
                  Where OLStatus = 1 AND ALStatus = 1 AND DegreeStatus = 1 AND DegreeField =" +"'" + f + "'";

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
