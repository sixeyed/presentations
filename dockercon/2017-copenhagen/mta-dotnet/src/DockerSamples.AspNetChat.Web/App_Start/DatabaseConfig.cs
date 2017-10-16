using DockerSamples.AspNetChat.Web.Logging;
using Polly;
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace DockerSamples.AspNetChat.Web
{
    public class DatabaseConfig
    {
        public static void InitializeDatabase()
        {
            //SQL backplane will deploy the schema, but not create the DB, so do that here:
            var connectionString = ConfigurationManager.ConnectionStrings["SignalR-backplane"].ConnectionString;
            if (connectionString.Contains("SignalR"))
            {
                var retryPolicy = Policy.Handle<SqlException>()
                                .WaitAndRetry(20, x => TimeSpan.FromMilliseconds(1000));

                retryPolicy.Execute(() => CreateSignalRDatabase(connectionString));
            }
         }

        private static void CreateSignalRDatabase(string connectionString)
        {            
            try
            {                
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
                Log.Info("Initialized SQL Server backplane for SignalR");
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Failed to initialize SQL Server backplane for SignalR");
            }
        }
    }
}