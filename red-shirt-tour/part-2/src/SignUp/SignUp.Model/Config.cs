using System;
using System.Collections.Generic;

namespace SignUp.Model
{
    public class Config
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string DbConnectionString { get { return Get("DB_CONNECTION_STRING"); } }

        public static string DbMaxRetryCount { get { return Get("DB_MAX_RETRY_COUNT"); } }

        public static string DbMaxDelaySeconds { get { return Get("DB_MAX_DELAY_SECONDS"); } }

        private static string Get(string variable)
        {
            if (!_Values.ContainsKey(variable))
            {
                var value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Machine);
                if (string.IsNullOrEmpty(value))
                {
                    value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Process);
                }
                _Values[variable] = value;
            }
            return _Values[variable];
        }
    }
}