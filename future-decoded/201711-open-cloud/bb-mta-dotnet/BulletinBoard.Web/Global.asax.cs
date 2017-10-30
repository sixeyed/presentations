using SignUp.Web.Logging;
using SignUp.Web.Model;
using System;
using System.Linq;
using System.Web;

namespace SignUp.Web
{
    public class Global : HttpApplication
    {
        private static bool _StartFailed = false;

        void Application_Start(object sender, EventArgs e)
        {
            try
            {
                using (var context = new BulletinBoardEntities())
                {
                    var count = context.Events.Count();
                    Log.Info("Connected to DB, found events: {0}", count);
                }
            }
            catch(Exception ex)
            {
                Log.Error(ex, "Exception in Application_Start");
                _StartFailed = true;
            }
        }

        void Application_BeginRequest(object sender, EventArgs e)
        {
            if (_StartFailed)
            {                
                Server.Transfer("Error.aspx");
            }
        }

        void Application_Error(object sender, EventArgs e)
        {
            var ex = Server.GetLastError();
            Log.Error(ex, "Unhandled exception");
        }       
    }
}