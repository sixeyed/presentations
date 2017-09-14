using System.Configuration;
using System.Data.SqlClient;

namespace DockerSamples.AspNetChat.Web
{
    public class DatabaseConfig
    {
        public static void InitializeDatabase()
        {
            //SQL backbone will deploy the schema, but not create the DB
            var connectionString = ConfigurationManager.ConnectionStrings["SignalR-Backbone"].ConnectionString;
            var masterConnectionString = connectionString.Replace("SignalR", "master");
            using (var sqlConnection = new SqlConnection(masterConnectionString))
            {
                sqlConnection.Open();
                using (var sqlCommand = sqlConnection.CreateCommand())
                {
                    sqlCommand.CommandText = "IF DB_ID('SignalR') IS NULL CREATE DATABASE SignalR";
                    sqlCommand.ExecuteNonQuery();
                }
            }
         }
    }
}