using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SLBFE_API.Models;
using System.Data;
using System.Data.SqlClient;

namespace SLBFE_API.Controllers
{
    [Route("api/jobseekers")]
    [ApiController]
    public class JobSeekersController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public JobSeekersController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Registers a new job seeker user
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPost, Route("register")]
        public ActionResult RegisterUser(JsUser user)
        {
            try
            {
                string query = @"insert into dbo.JS_USERS values(@NIC,@Email,@FirstName,@LastName,@DOB,@Address,@Latitude,@Longitude,@Profession,@Affiliation,@Gender,@Nationality,@MaritalStatus,@Validity,@PrimaryPhone)";
                string query1 = @"insert into dbo.JS_CONTACTS values(@JS_NIC,@Personal,@Work,@Emmergency)";
                string query2 = @"insert into dbo.USER_AUTH values(@UserID,@Password,'JS')";
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
                        myCommand.Parameters.AddWithValue("@FirstName", user.FirstName);
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

                        myCommand.Parameters.AddWithValue("@JS_NIC", user.Nic.ToString());
                        myCommand.Parameters.AddWithValue("@Personal", user.PrimaryPhone);
                        myCommand.Parameters.AddWithValue("@Work", ' ');
                        myCommand.Parameters.AddWithValue("@Emmergency", ' ');


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
                    return new JsonResult("Added Successfully!");
                }
            }
            catch (Exception ex)
            {
                return BadRequest("Registration Error!");
            }
        }

        /// <summary>
        /// Returns details of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpGet,Route("{NIC}")]
        [Authorize]
        public ActionResult GetUser(String NIC)
        {
            try
            {
                string query = @"select NIC,Email,FirstName,LastName,DOB,Address,Latitude,Longitude,Profession,Affiliation,Gender,Nationality,MaritalStatus,Validity,PrimaryPhone from dbo.Js_Users
                   Where NIC ='" + NIC + "' ";
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
                if(table.Rows.Count != 0)
                {
                    return new JsonResult(table);
                }
                else
                {
                    return NotFound("No User by that NIC");
                }
            }
            catch(Exception ex)
            {
                return BadRequest();
            }
        }

        /// <summary>
        /// Updates the details of a specific user
        /// </summary>
        /// <param name="user"></param>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/update")]
        [Authorize(Roles = "JS")]
        public JsonResult userDetailsUpdate(JsUser user,String NIC)
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

        /// <summary>
        /// Deletes the account of a specific user
        /// </summary>
        /// <param name="nic"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpDelete, Route("{NIC}/delete")]
        [Authorize(Roles = "JS")]
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

        /// <summary>
        /// Deactivates the account of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpDelete, Route("{NIC}/deactivate")]
        [Authorize(Roles = "BO")]
        public JsonResult DeactivateUser(int NIC)
        {
            string queryDeleteUser = @"delete from dbo.Js_Users where NIC=@NIC";
            string queryDeleteContacts = @"delete from dbo.JS_Contacts where JS_NIC=@NIC";
            string queryDeleteQualifications = @"delete from dbo.JS_QUALIFICATIONS where JS_NIC=@NIC";
            string queryDeleteComplains = @"delete from dbo.JS_COMPLAINS where JS_NIC=@NIC";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(queryDeleteContacts, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", NIC);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();

                }
                using (SqlCommand myCommand = new SqlCommand(queryDeleteQualifications, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", NIC);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();

                }
                using (SqlCommand myCommand = new SqlCommand(queryDeleteComplains, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", NIC);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();

                }

                using (SqlCommand myCommand = new SqlCommand(queryDeleteUser, myCon))
                {
                    myCommand.Parameters.AddWithValue("@NIC", NIC);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Delteted Successfully!");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        /*[HttpGet, Route("{email}/nic")]
        [Authorize(Roles = "JS")]
        public ActionResult JsUserLogin(String email)
        {
            string query = @"SELECT NIC
                  FROM dbo.JS_USERS
                  Where Email ='" +email+"' ";

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

        /// <summary>
        /// Returns contact details of a specific user
        /// </summary>
        /// <param name="nic"></param>
        /// <returns></returns>
        [HttpGet, Route("{NIC}/contacts")]
        [Authorize(Roles = "BO")]
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

        /// <summary>
        /// Updates the contact details of a specific user
        /// </summary>
        /// <param name="contact"></param>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/contacts/update")]
        [Authorize(Roles = "JS")]
        public JsonResult updateUserContacts(JsContact contact,string NIC)
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

        /// <summary>
        /// Returns the geo coordinates or a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpGet, Route("{NIC}/location")]
        [Authorize(Roles = "BO")]
        public JsonResult GetComplaintListapp(int NIC)
        {
            string query = @"SELECT NIC, Latitude, Longitude FROM dbo.JS_USERS WHERE NIC = " + NIC;
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

        /// <summary>
        /// Updates the geo coordinates of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <param name="lat"></param>
        /// <param name="lng"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/location/update")]
        [Authorize(Roles = "JS")]
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

        /// <summary>
        /// Returns the qualifications of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpGet, Route("{NIC}/qualifications")]
        [Authorize(Roles = "BO")]
        public JsonResult Qualifications(int NIC)
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

        /// <summary>
        /// Updates the qualifications of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <param name="olEnglish"></param>
        /// <param name="olScience"></param>
        /// <param name="olMaths"></param>
        /// <param name="alStream"></param>
        /// <param name="alResults"></param>
        /// <param name="alEnglish"></param>
        /// <param name="hEdu"></param>
        /// <param name="hEduField"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/qualifications/update")]
        [Authorize(Roles = "JS")]
        public ActionResult updateQualifications(int NIC, string olEnglish, string olScience, string olMaths, string alStream, string alResults, string alEnglish, string hEdu, string hEduField)
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
                WHERE JS_NIC = {NIC};
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="nic"></param>
        /// <param name="password"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Updates the password of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/password/update")]
        [Authorize(Roles = "JS")]
        public JsonResult updatePassword(String NIC, String password)
        {
            string query = @"update dbo.USER_AUTH set Password='"+password + "' where UserID='"+NIC+"'";

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

        /// <summary>
        /// Updates the validity status of a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        [HttpPut, Route("{NIC}/validity/update")]
        [Authorize(Roles = "BO")]
        public JsonResult updateValidity(int NIC, bool status)
        {
            string query = @$"UPDATE dbo.JS_USERS SET Validity={status} WHERE NIC=" + NIC;
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
            return new JsonResult("Validated Successfully!");
        }

        /// <summary>
        /// Returns a list of users that are not yet marked as validated
        /// </summary>
        /// <returns></returns>
        [HttpGet, Route("non-validated")]
        [Authorize(Roles = "BO")]
        public JsonResult GetUsersToValidate()
        {
            string query = @"SELECT [NIC]
                  ,[Email]
                  ,[FirstName]
                  ,[LastName]
                  ,[DOB]
                  ,[Address]
                  ,[Latitude]
                  ,[Longitude]
                  ,[Profession]
                  ,[Affiliation]
                  ,[Gender]
                  ,[Nationality]
                  ,[MaritalStatus]
                  ,[Validity]
                  ,[PrimaryPhone]
              FROM [dbo].[JS_USERS]
              WHERE Validity = 'False';";
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

        
        /// <summary>
        /// Returns a user or a list of users by the given NIC or name
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        [HttpGet, Route("search")]
        [Authorize]
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

        /// <summary>
        /// Returns a list of users that matches with the given qualifications
        /// </summary>
        /// <param name="filterOn"></param>
        /// <param name="olEnglish"></param>
        /// <param name="olScience"></param>
        /// <param name="olMaths"></param>
        /// <param name="alStream"></param>
        /// <param name="alResults"></param>
        /// <param name="hEdu"></param>
        /// <param name="hEduField"></param>
        /// <returns></returns>
        [HttpGet, Route("search/by-qualifications")]
        [Authorize(Roles = "BO,FC")]
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

            if (filterOn)
            {

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


/*        [HttpGet, Route("getuserdetails")]
        public JsonResult GetUserDetails(int nic)
        {
            string query = @"SELECT [NIC]
                  ,[Email]
                  ,[FirstName]
                  ,[LastName]
                  ,[DOB]
                  ,[Address]
                  ,[Latitude]
                  ,[Longitude]
                  ,[Profession]
                  ,[Affiliation]
                  ,[Gender]
                  ,[Nationality]
                  ,[MaritalStatus]
                  ,[Validity]
                  ,[PrimaryPhone]
              FROM [dbo].[JS_USERS]
              WHERE NIC =" + nic + ";";
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
        }*/

    }
}
