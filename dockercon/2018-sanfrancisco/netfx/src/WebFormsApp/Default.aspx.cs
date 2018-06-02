using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using WebFormsApp.Logging;
using System.Text;

namespace WebFormsApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Log.Info("Page loaded");
            tblCellLevel.Text = Log.GetLogLevel();
            tblCellAppender.Text = Log.GetAppenderName();
            tblCellTarget.Text = Log.GetAppenderTarget();
            tblCellLogCount.Text = ConfigurationManager.AppSettings["LogCount"];
        }

        protected void btnLog_Click(object sender, EventArgs e)
        {
            int logCount = int.Parse(ConfigurationManager.AppSettings["LogCount"]);
            for (int i = 1; i <= logCount; i++)
            {
                Log.Debug("Debug log {0}", i);
                Log.Info("Info log {0}", i);
                Log.Warn("Warn log {0}", i);
                Log.Error("Error log {0}", i);
                Log.Fatal("Fatal log {0}", i);
            }
        }
    }
}
