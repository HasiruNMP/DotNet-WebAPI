using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using SLBFE_API.Models;
using Microsoft.AspNetCore.Authorization;

namespace SLBFE_API.Controllers
{
    [Route("complaints")]
    [ApiController]
    public class ComplaintsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public ComplaintsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        /// <summary>
        /// Returns the list of complaints that haven't got a feedback yet
        /// </summary>
        [HttpGet,Route("all/new")]
        [Authorize(Roles = "BO")]
        public JsonResult GetNewComplaintList()
        {
            string query = @"SELECT * FROM [dbo].[JS_COMPLAINS] WHERE Feedback = 'No Feedback'";
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
        /// Returns the list of complaints that feedbacks have been sent
        /// </summary>
        /// <returns></returns>
        [HttpGet, Route("all/replied")]
        [Authorize(Roles = "BO")]
        public JsonResult GetOldComplaintList()
        {
            string query = @"SELECT * FROM [dbo].[JS_COMPLAINS] WHERE Feedback != 'No Feedback'";
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
        /// Updates the feedback for the complaint of the given id
        /// </summary>
        /// <param name="ComplaintID"></param>
        /// <param name="feedback"></param>
        /// <returns></returns>
        [HttpPut,Route("{ComplaintID}/feedback/update")]
        [Authorize(Roles = "BO")]
        public JsonResult PutFeedback(int ComplaintID, String feedback)
        {
            string query = @"UPDATE [dbo].[JS_COMPLAINS] SET Feedback = '" + feedback + "' WHERE ComplaintID =" + ComplaintID;
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
            return new JsonResult("Updated Successfully");
        }

        /// <summary>
        /// Adds a new complaint
        /// </summary>
        /// <param name="comp"></param>
        /// <returns></returns>
        [HttpPost,Route("new")]
        [Authorize(Roles = "JS")]
        public JsonResult PostComplaint(JsComplain comp)
        {
            string query = @"insert into [dbo].[JS_COMPLAINS] values(@JS_NIC,@Complain,@Feedback,@AddedDate)";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    //myCommand.Parameters.AddWithValue("@NIC", comp.JsNicNavigation);
                
                    myCommand.Parameters.AddWithValue("@JS_NIC", comp.JsNic);
                    myCommand.Parameters.AddWithValue("@Complain", comp.Complain);
                    myCommand.Parameters.AddWithValue("@Feedback", comp.Feedback);
                    myCommand.Parameters.AddWithValue("@AddedDate", comp.Date);


                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Added Successfully");
        }

        /// <summary>
        /// returns a list of complaints that have been made by a specific user
        /// </summary>
        /// <param name="NIC"></param>
        /// <returns></returns>
        [HttpGet, Route("ofuser/{NIC}")]
        [Authorize(Roles = "JS,BO")]
        public JsonResult GetComplaintListapp(int NIC)
        {
            string query = @"SELECT * FROM [dbo].[JS_COMPLAINS] WHERE JS_NIC =" + NIC;
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

    }

    
}
