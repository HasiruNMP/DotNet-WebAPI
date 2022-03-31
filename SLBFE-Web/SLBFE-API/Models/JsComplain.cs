using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class JsComplain
    {
        public int ComplaintId { get; set; }
        public int JsNic { get; set; }
        public string Complain { get; set; } = null!;
        public string Feedback { get; set; } = null!;

        public virtual JsUser JsNicNavigation { get; set; } = null!;
    }
}
