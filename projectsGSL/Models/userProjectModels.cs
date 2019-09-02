using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace projectsGSL.Models
{
    public class userProjectModels
    {
        public int userId { get; set; }
        public int projectId { get; set; }
        public bool isActive { get; set; }
        public DateTime assignedDate { get; set; }
    }
}