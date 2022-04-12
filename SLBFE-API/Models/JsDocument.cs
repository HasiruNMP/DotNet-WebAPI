using System;
using System.Collections.Generic;

namespace SLBFE_API.Models
{
    public partial class JsDocument
    {
        public int DocId { get; set; }
        public int JsNic { get; set; }
        public string Olevel { get; set; } = null!;
        public string Alevel { get; set; } = null!;
        public string BirthCertificate { get; set; } = null!;
        public string Cv { get; set; } = null!;
        public string Passport { get; set; } = null!;
        public string DrivingLicence { get; set; } = null!;
        public string VaccineCard { get; set; } = null!;
        public string Degree { get; set; } = null!;

        public virtual JsUser JsNicNavigation { get; set; } = null!;
    }
}
