using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebFormsApp.Database
{
    public class SqlDateTime
    {
        public static DateTime Now()
        {
            object now;
            string connectionString = ConfigurationManager.ConnectionStrings["SqlDb"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT GETDATE()";
                    cmd.CommandType = CommandType.Text;
                    now = cmd.ExecuteScalar();
                }
            }
            return (DateTime)now;
        }
    }
}
