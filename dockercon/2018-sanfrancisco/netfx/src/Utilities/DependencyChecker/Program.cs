using Polly;
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace DependencyChecker
{
    class Program
    {
        static int Main(string[] args)
        {
            var sqlPolicy = Policy.Handle<SqlException>()
                                  .Retry(3, (exception, retryCount) =>
                                   {
                                       Console.WriteLine("DEPENDENCY: Got SQL exception {0}, retryCount {1}", exception.GetType(), retryCount);
                                   });

            var result = sqlPolicy.ExecuteAndCapture(() => ConnectToSqlServer());
            if (result.Outcome == OutcomeType.Successful)
            {
                Console.WriteLine("DEPENDENCY: OK");
                return 0;
            }
            else
            {
                Console.WriteLine("DEPENDENCY: FAILED");
                return 1;
            }
        }

        private static void ConnectToSqlServer()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SqlDb"].ConnectionString;
            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();
            }
        }
    }
}