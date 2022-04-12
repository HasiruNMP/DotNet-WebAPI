using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class BoUser
    {
        public string Email { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Name { get; set; } = null!;
    }
}
