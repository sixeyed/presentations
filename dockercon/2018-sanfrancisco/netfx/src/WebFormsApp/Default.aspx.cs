using System;
using System.Configuration;
using WebFormsApp.Logging;
using WebFormsApp.Database;
using System.Net;

namespace WebFormsApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Log.Info("Page loaded");
            lblServer.Text = Dns.GetHostName();
            tblCellLevel.Text = Log.GetLogLevel();
            tblCellAppender.Text = Log.GetAppenderName();
            tblCellTarget.Text = Log.GetAppenderTarget();
            tblCellLogCount.Text = ConfigurationManager.AppSettings["LogCount"];
            tblCellSqlServer.Text = ConfigurationManager.ConnectionStrings["SqlDb"].ConnectionString.Split(';')[0].Split('=')[1];
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
            lblLogOutput.Text = string.Format("Wrote {0} log entries", logCount);
        }

        protected void btnSql_Click(object sender, EventArgs e)
        {
            lblSqlOutput.Text = string.Format("Database time: {0}", SqlDateTime.Now());
        }
    }
}
