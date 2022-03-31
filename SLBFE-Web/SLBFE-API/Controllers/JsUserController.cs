using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SLBFE_API.Models;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class JsUserController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public JsUserController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        [HttpGet]
        public JsonResult GetUser()
        {
            string query = @"select NIC,Email,Password,FirstName,LastName,DOB,Address,Latitude,Longitude,Profession,Affiliation,Gender,Nationality,MaritalStatus,Validity,PrimaryPhone from dbo.Js_Users";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using(SqlConnection myCon=new SqlConnection(sqlDataSource))
            {
                myCon.Open();   
                using(SqlCommand myCommand = new SqlCommand(query,myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();

                }
            }
            return new JsonResult(table);
        }


        [HttpPost]
        public JsonResult PostUser(JsUser user)
        {
            string query = @"insert into dbo.Js_Users values(@NIC,@Email,@Password,@FirstName,@LastName,@DOB,@Address,@Latitude,@Longitude,@Profession,@Affiliation,@Gender,@Nationality,@MaritalStatus,@Validity,@PrimaryPhone)";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", user.Nic);
                    myCommand.Parameters.AddWithValue("@Email", user.Email);
                    myCommand.Parameters.AddWithValue("@Password", user.Password);
                    myCommand.Parameters.AddWithValue("@FirstName", user.FirstName );
                    myCommand.Parameters.AddWithValue("@LastName", user.LastName);
                    myCommand.Parameters.AddWithValue("@DOB", user.Dob);
                    myCommand.Parameters.AddWithValue("@Address", user.Address);
                    myCommand.Parameters.AddWithValue("@Latitude", user.Latitude);
                    myCommand.Parameters.AddWithValue("@Longitude", user.Longitude);
                    myCommand.Parameters.AddWithValue("@Profession", user.Profession);
                    myCommand.Parameters.AddWithValue("@Affiliation", user.Affiliation);
                    myCommand.Parameters.AddWithValue("@Gender", user.Gender);
                    myCommand.Parameters.AddWithValue("@Nationality", user.Nationality);
                    myCommand.Parameters.AddWithValue("@MaritalStatus", user.MaritalStatus);
                    myCommand.Parameters.AddWithValue("@Validity", user.Validity);
                    myCommand.Parameters.AddWithValue("@PrimaryPhone", user.PrimaryPhone);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();

                }
            }
            return new JsonResult("Added Successfully!");
        }



        [HttpPut]
        public JsonResult PutUser(JsUser user)
        {
            string query = @"update dbo.Js_Users set FirstName=@FirstName,LastName=@LastName,
            Address=@Address,Profession=@Profession,Affiliation=@Affiliation,Gender=@Gender,Nationality=@Nationality,
            MaritalStatus=@MaritalStatus,Validity=@Validity,PrimaryPhone=@PrimaryPhone
            where NIC=@NIC";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", user.Nic);
                    myCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
                    myCommand.Parameters.AddWithValue("@LastName", user.LastName);
                    myCommand.Parameters.AddWithValue("@DOB", user.Dob);
                    myCommand.Parameters.AddWithValue("@Address", user.Address);
                    myCommand.Parameters.AddWithValue("@Profession", user.Profession);
                    myCommand.Parameters.AddWithValue("@Affiliation", user.Affiliation);
                    myCommand.Parameters.AddWithValue("@Gender", user.Gender);
                    myCommand.Parameters.AddWithValue("@Nationality", user.Nationality);
                    myCommand.Parameters.AddWithValue("@MaritalStatus", user.MaritalStatus);
                    myCommand.Parameters.AddWithValue("@Validity", user.Validity);
                    myCommand.Parameters.AddWithValue("@PrimaryPhone", user.PrimaryPhone);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();

                }
            }
            return new JsonResult("Updated Successfully!");
        }
    }
}
