using System;
using System.Collections.Generic;

namespace SignUp.Model
{
    public class Config
    {
        private static Dictionary<string, string> _Values = new Dictionary<string, string>();

        public static string DbConnectionStringPath { get { return Get("DB_CONNECTION_STRING_PATH"); } }
        
        public static string DbMaxRetryCount { get { return Get("DB_MAX_RETRY_COUNT", "5"); } }

        public static string DbMaxDelaySeconds { get { return Get("DB_MAX_DELAY_SECONDS", "10"); } }

        private static string Get(string variable, string defaultValue = null)
        {
            if (!_Values.ContainsKey(variable))
            {
                var value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Machine);
                if (string.IsNullOrEmpty(value))
                {
                    value = Environment.GetEnvironmentVariable(variable, EnvironmentVariableTarget.Process);
                }
                if (string.IsNullOrEmpty(value))
                {
                    value = defaultValue;
                }
                _Values[variable] = value;
            }
            return _Values[variable];
        }
    }
}