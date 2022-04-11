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
        public ActionResult SearchByQualifications(string? olEnglish, string? olScience, string? olMaths, string? alStream, string? alResults, string? hEdu, string? hEduField, bool filterOn)
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
                      ,[OLScience]
                      ,[OLMaths]
                      ,[OLEnglish]
                      ,[ALStream]
                      ,[ALResults]
                      ,[ALEnglish]
                      ,[HigherEducation]
                      ,[HigherEducationField]
                  FROM [dbo].[JSUserQualifications]";

            if (filterOn) {

                query = query + " WHERE 1=1";

                if (olEnglish != null) { query = query + $" AND [OLEnglish] = '{olEnglish}'"; }
                if (olScience != null) { query = query + $" AND [OLScience] = '{olScience}'"; }
                if (olMaths != null) { query = query + $" AND [OLMaths] = '{olMaths}'"; }
                if (alStream != null) { query = query + $" AND [ALStream] = '{alStream}'"; }
                if (alResults != null) { query = query + $" AND [ALResults] = '{alResults}'"; }
                if (hEdu != null) { query = query + $" AND [HigherEducation] = '{hEdu}'"; }
                if (hEduField != null) { query = query + $" AND [HigherEducationField] = '{hEduField}'"; }
            }

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
