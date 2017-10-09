using DockerSamples.AspNetChat.Web.Logging;
using Microsoft.AspNet.SignalR;
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace DockerSamples.AspNetChat.Web.Hubs
{
    public class ChatHub : Hub
    {
        private static string _AuditDbConnectionString; 

        static ChatHub()
        {
            _AuditDbConnectionString = ConfigurationManager.ConnectionStrings["Audit-DB"].ConnectionString;
        }

        public void Send(string name, string message)
        {
            AuditMessage(name, message);
            Clients.All.addNewMessageToPage(name, message);
        }

        private static void AuditMessage(string name, string message)
        {
            try
            {
                var sqlCmd = $"INSERT INTO ChatAudit([User], [Message]) VALUES('{name}', '{message}');";
                using (var sqlConnection = new SqlConnection(_AuditDbConnectionString))
                {
                    sqlConnection.Open();
                    using (var sqlCommand = sqlConnection.CreateCommand())
                    {
                        sqlCommand.CommandText = sqlCmd;
                        sqlCommand.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to save message audit");
            }
        }
    }
}