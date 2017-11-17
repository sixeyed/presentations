using System;
using System.Data.Entity;
using System.Data.Entity.SqlServer;

namespace SignUp.Model
{
    public class SignUpConfiguration : DbConfiguration
    {
        public SignUpConfiguration()
        {
            var maxRetryCount = int.Parse(Config.DbMaxRetryCount);
            var maxDelaySeconds = int.Parse(Config.DbMaxDelaySeconds);

            Console.WriteLine($"- Setting DbConfiguration - maxRetryCount: {maxRetryCount}, maxDelaySeconds: {maxDelaySeconds}");

            SetExecutionStrategy("System.Data.SqlClient", () =>
                new SqlAzureExecutionStrategy(maxRetryCount, TimeSpan.FromSeconds(maxDelaySeconds)));
        }
    }
}
