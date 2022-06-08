using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using SLBFE_API.Models;
using System.Data;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace SLBFE_API.Controllers
{
    [Route("api/auth")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public AuthController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        private UserAuth GetCurrentUser()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            if (identity != null)
            {
                var userClaims = identity.Claims;

                return new UserAuth
                {
                    UserType = userClaims.FirstOrDefault(o => o.Type == ClaimTypes.Role)?.Value
                };
            }
            return null;
        }

        /// <summary>
        /// Authenticates a user and returns a API token
        /// </summary>
        /// <param name="toLogin">User credentials and user type</param>
        /// <returns>JSON Web Token</returns>
        /// /// <response code="404">if no user found by the given credentials</response>
        [HttpPost, Route("login")]
        public ActionResult Login(UserAuth toLogin)
        {
            UserAuth? user = AuthenticateUser(toLogin);

            if (user != null)
            {
                var token = GenerateToken(user);
                return Ok(token);
            }

            return NotFound("User Not Found");
        }

        private string GenerateToken(UserAuth user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(ClaimTypes.Role, user.UserType)
            };

            var token = new JwtSecurityToken(_configuration["Jwt:Issuer"],
              _configuration["Jwt:Audience"],
              claims,
              expires: DateTime.Now.AddDays(30),
              signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private UserAuth? AuthenticateUser(UserAuth toLogin)
        {
            UserAuth newUser = new UserAuth();

            string query = $@"SELECT UserID,Password,UserType
                FROM dbo.USER_AUTH
                Where UserID ='" + toLogin.UserID +
                "'  AND Password ='" + toLogin.Password +
                "' AND UserType ='" + toLogin.UserType +
                "'";

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

            if(table.Rows.Count == 1)
            {
                newUser.UserID = table.Rows[0]["UserID"].ToString();
                newUser.Password = table.Rows[0]["Password"].ToString();
                newUser.UserType = table.Rows[0]["UserType"].ToString();
                return newUser;
            }
            else
            {
                return null;
            }


        }

    }
}
