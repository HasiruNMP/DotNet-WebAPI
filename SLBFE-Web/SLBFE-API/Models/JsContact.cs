using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class JsContact
    {
        public int ContactId { get; set; }
        public int JsNic { get; set; }
        public string Personal { get; set; } = null!;
        public string Work { get; set; } = null!;
        public string Emmergency { get; set; } = null!;

        public virtual JsUser JsNicNavigation { get; set; } = null!;
    }
}
