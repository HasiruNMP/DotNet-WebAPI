using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class FcUser
    {
        public int Fcid { get; set; }
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Name { get; set; } = null!;
        public string CompanyName { get; set; } = null!;
    }
}
