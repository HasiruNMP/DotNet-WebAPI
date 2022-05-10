using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    [Route("jobseekers/")]
    [ApiController]
    public class QualificationsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public QualificationsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet, Route("search/byname")]
        public ActionResult SearchByKeyword(string keyword)
        {
            try
            {
                string query = $@"SELECT * FROM dbo.JS_USERS WHERE FirstName LIKE '{keyword}' OR LastName LIKE '{keyword}' OR NIC LIKE '{keyword}';";
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
                return new JsonResult(table);
            }
            catch (Exception ex)
            {
                return BadRequest();
            }
        }

        [HttpGet, Route("search")]
        //[Authorize(Roles = "BO,FC")]
        public ActionResult SearchByQualifications(bool filterOn, string? olEnglish, string? olScience, string? olMaths, string? alStream, string? alResults, string? hEdu, string? hEduField)
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

                if (olEnglish != "Any") { query = query + $" AND [OLEnglish] = '{olEnglish}'"; }
                if (olScience != "Any") { query = query + $" AND [OLScience] = '{olScience}'"; }
                if (olMaths != "Any") { query = query + $" AND [OLMaths] = '{olMaths}'"; }
                if (alStream != "Any") { query = query + $" AND [ALStream] = '{alStream}'"; }
                if (alResults != "Any") { query = query + $" AND [ALResults] = '{alResults}'"; }
                if (hEdu != "Any") { query = query + $" AND [HigherEducation] = '{hEdu}'"; }
                if (hEduField != "Any") { query = query + $" AND [HigherEducationField] = '{hEduField}'"; }
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


        [HttpGet, Route("qualifications/ofuser")]
        public JsonResult GetComplaintListapp(int NIC)
        {
            string query = @"SELECT * FROM [dbo].[JS_QUALIFICATIONS] WHERE JS_NIC =" + NIC;
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
            return new JsonResult(table);
        }


        [HttpPut, Route("qualifications/update")]
        public ActionResult updateQualifications(int nic, string olEnglish, string olScience, string olMaths, string alStream, string alResults, string alEnglish, string hEdu, string hEduField)
        {
            string query = $@"
                UPDATE [dbo].[JS_QUALIFICATIONS] 
                SET 
                OLScience = '{olScience}',
                OLEnglish = '{olEnglish}',
                OLMaths = '{olMaths}',
                ALStream = '{alStream}',
                ALResults = '{alResults}',
                ALEnglish = '{alEnglish}',
                HigherEducation = '{hEdu}',
                HigherEducationField = '{hEduField}'
                WHERE JS_NIC = {nic};
                ";

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
            return Ok("Qualification Update Succesful!");
        }

    }
}
