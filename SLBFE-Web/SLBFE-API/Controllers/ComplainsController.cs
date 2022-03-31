using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using SLBFE_API.Models;

namespace SLBFE_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ComplainsController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public ComplainsController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public JsonResult GetComplain(int NIC)
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

        [HttpPut]
        public JsonResult PutFeedback(JsComplain comp)
        {
            string query = @"UPDATE [dbo].[JS_COMPLAINS] SET Feedback = @Feedback WHERE ComplaintID = @ComplaintID";
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SLBFEDB");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@ComplaintID", comp.ComplaintId);
                    myCommand.Parameters.AddWithValue("@Feedback", comp.Feedback);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }
            return new JsonResult("Updated Successfully");
        }

    }

    
}
