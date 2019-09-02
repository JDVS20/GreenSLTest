using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projectsGSL.ViewModel
{
    public class viewUserProjectsModel
    {
        public int projectId { get; set; }
        public string startDate { get; set; }
        public string timeStart { get; set; }
        public string endDate { get; set; }
        public string credits { get; set; }
        public string status { get; set; }
    }
}