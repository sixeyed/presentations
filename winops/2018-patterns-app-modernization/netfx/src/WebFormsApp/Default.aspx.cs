using System;
using System.Configuration;
using WebFormsApp.Logging;
using WebFormsApp.Database;
using System.Net;
using System.Threading;

namespace WebFormsApp
{
    public partial class _Default : System.Web.UI.Page
    {
        static Random _Random = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {
            bool slowMode = _Random.Next(10) > 6;
            Log.Info("Page loaded, slowMode: {0}", slowMode); 
            if (slowMode)
            {                
                Thread.Sleep(200);
            }
            SetLabelText(slowMode);            
        }

        private void SetLabelText(bool slowMode)
        {            
            lblServer.Text = Dns.GetHostName();
            if (slowMode)
            {
                lblServer.Text += " [SLOW MODE]";
            }
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
