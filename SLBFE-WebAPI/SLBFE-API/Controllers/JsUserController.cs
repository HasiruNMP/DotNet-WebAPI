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
        public JsonResult GetUser(String nic)
        {
            string query = @"select NIC,Email,Password,FirstName,LastName,DOB,Address,Latitude,Longitude,Profession,Affiliation,Gender,Nationality,MaritalStatus,Validity,PrimaryPhone from dbo.Js_Users
            Where NIC ='" + nic + "' ";
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


        [HttpPost ,Route("registerUser")]
        public JsonResult PostUser(JsUser user)
        {
            string query = @"insert into dbo.Js_Users values(@NIC,@Email,@Password,@FirstName,@LastName,@DOB,@Address,@Latitude,@Longitude,@Profession,@Affiliation,@Gender,@Nationality,@MaritalStatus,@Validity,@PrimaryPhone)";
            string query1 = @"insert into dbo.JS_CONTACTS values(@JS_NIC,@Personal,@Work,@Emmergency)";
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
                    myCommand.Parameters.AddWithValue("@Latitude", 0);
                    myCommand.Parameters.AddWithValue("@Longitude", 0);
                    myCommand.Parameters.AddWithValue("@Profession", user.Profession);
                    myCommand.Parameters.AddWithValue("@Affiliation", user.Affiliation);
                    myCommand.Parameters.AddWithValue("@Gender", user.Gender);
                    myCommand.Parameters.AddWithValue("@Nationality", user.Nationality);
                    myCommand.Parameters.AddWithValue("@MaritalStatus", user.MaritalStatus);
                    myCommand.Parameters.AddWithValue("@Validity", false);
                    myCommand.Parameters.AddWithValue("@PrimaryPhone", user.PrimaryPhone);

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                 

                }
       
                using (SqlCommand myCommand = new SqlCommand(query1, myCon))
                {
         
                    myCommand.Parameters.AddWithValue("@JS_NIC",user.Nic.ToString());
                    myCommand.Parameters.AddWithValue("@Personal", user.PrimaryPhone);
                    myCommand.Parameters.AddWithValue("@Work",' ' );
                    myCommand.Parameters.AddWithValue("@Emmergency", ' ');
       

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();

                }
            }
            return new JsonResult("Added Successfully!");
        }



        [HttpPut, Route("UpdateUserDetails")]
        public JsonResult userDetailsUpdate(JsUser user)
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


        [HttpDelete]
        public JsonResult DeleteUser(int nic,String password)
        {
            string query = @"delete from dbo.Js_Users where NIC=@NIC";
            string query1 = @"delete from dbo.JS_Contacts where JS_NIC=@NIC";
            string query2 = @"delete from dbo.JS_QUALIFICATIONS where JS_NIC=@NIC";
            string query3 = @"delete from dbo.JS_COMPLAINS where JS_NIC=@NIC";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query1, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", nic);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                  
                }
                using (SqlCommand myCommand = new SqlCommand(query2, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", nic);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                  
                }
                using (SqlCommand myCommand = new SqlCommand(query3, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", nic);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();

                }

                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", nic);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Delteted Successfully!");
        }


        [HttpGet, Route("login")]
        public ActionResult JsUserLogin(String email, String password)
        {
            string query = @"SELECT Email
                      ,Password,NIC
                  FROM dbo.JS_USERS
                  Where Email ='" +email+"'  AND Password ='"+password+"'";

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

        [HttpGet, Route("getContacts")]
        public JsonResult GetUserContacts(int nic)
        {
            string query = @"select JS_NIC,Personal,Work,Emmergency from dbo.JS_CONTACTS
            Where JS_NIC ='" + nic + "' ";
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

        [HttpPut, Route("UpdateUserContacts")]
        public JsonResult updateUserContacts(JsContact contact)
        {
            string query = @"update dbo.JS_CONTACTS set Personal=@Personal,
            Work=@Work,Emmergency=@Emmergency
            where JS_NIC=@NIC";
            string query1 = @"update dbo.JS_USERS set PrimaryPhone=@PrimaryPhone
            where NIC=@NIC";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", contact.JsNic);
                    myCommand.Parameters.AddWithValue("@Personal", contact.Personal);
                    myCommand.Parameters.AddWithValue("@Work",contact.Work);
                    myCommand.Parameters.AddWithValue("@Emmergency", contact.Emmergency);
   
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                   

                }
           
                using (SqlCommand myCommand = new SqlCommand(query1, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", contact.JsNic);
                    myCommand.Parameters.AddWithValue("@PrimaryPhone", contact.Personal);
              

                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();

                }
            }
            return new JsonResult("Updated Successfully!");
        }


        [HttpPut, Route("updatelocation")]
        public JsonResult updateLocation(int NIC, double lat, double lng)
        {
            string query = @"UPDATE dbo.JS_USERS SET Latitude=" + lat + ",Longitude=" + lng + " WHERE NIC=" + NIC;
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
                }
            }
            return new JsonResult("Updated Successfully!");
        }

        [HttpGet, Route("checkPassword")]
        public ActionResult checkPassword(int nic, String password)
        {
            string query = @"SELECT 
                    NIC,Password
                  FROM dbo.JS_USERS
                  Where NIC ='" + nic + "'  AND Password ='" + password + "'";

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

        [HttpPut, Route("updatePassword")]
        public JsonResult updatePassword(int nic, String password)
        {
            string query = @"update dbo.Js_Users set Password='"+password + "' where NIC='"+nic+"'";

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
            return new JsonResult("Password Updated Successfully!");
        }


    }
}
