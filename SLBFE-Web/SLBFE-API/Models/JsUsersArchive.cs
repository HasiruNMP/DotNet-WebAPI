using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class JsUsersArchive
    {
        public int ArchiveId { get; set; }
        public int Nic { get; set; }
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public DateTime Dob { get; set; }
        public string Address { get; set; } = null!;
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string Profession { get; set; } = null!;
        public string Affiliation { get; set; } = null!;
        public string Gender { get; set; } = null!;
        public string Nationality { get; set; } = null!;
        public string MaritalStatus { get; set; } = null!;
        public bool Validity { get; set; }
    }
}
