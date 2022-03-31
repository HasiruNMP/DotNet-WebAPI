using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class JsQualification
    {
        public int QualificationId { get; set; }
        public int JsNic { get; set; }
        public bool Olstatus { get; set; }
        public bool Alstatus { get; set; }
        public bool DegreeStatus { get; set; }
        public string DegreeField { get; set; } = null!;

        public virtual JsUser JsNicNavigation { get; set; } = null!;
    }
}
