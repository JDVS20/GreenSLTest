using projectGSL.DA;
using projectsGSL.ViewModel;
using System.Data;
using System.Linq;
using System.Web.Mvc;

namespace projectsGSL.Controllers
{
    public class UserProjectController : Controller
    {
        private projectsGSLEntities dbcontext = new projectsGSLEntities();

        public ActionResult Index()
        {
            getProjectList();
            getUserList();
            return View();
        }

        //Get the list of projects
        public ActionResult getProjectList()
        {    
            var query = (from c in dbcontext.viewUserProjects
                         select new viewUserProjectsModel
                         {
                             projectId = c.projectId
                             , startDate = c.startDate
                             , timeStart = c.timestart
                             , endDate = c.endDate
                             , credits = c.credits.ToString()
                             , status = c.status
                         }).ToList();            

            ViewBag.dataUserProjects = query.ToList();
            return View();
        }
       
        //Get list of user
        public ActionResult getUserList()
        {
            var query = dbcontext.tb_User.ToList();
            ViewBag.dataUser = query;
            return View();
        }

        // Get list of projects assigned user
        public ActionResult getUserProjectList(int userId)
        {
            var query = (from c in dbcontext.viewUserProjects
                         join x in dbcontext.tb_UserProject on c.projectId equals x.projectId
                         where x.userId == userId
                         select new viewUserProjectsModel
                         {
                             projectId = c.projectId
                             , startDate = c.startDate
                             , timeStart = c.timestart
                             , endDate = c.endDate
                             , credits = c.credits.ToString()
                             , status = c.status
                         }
                         ).ToList();            

            return View();

        }

    }
}