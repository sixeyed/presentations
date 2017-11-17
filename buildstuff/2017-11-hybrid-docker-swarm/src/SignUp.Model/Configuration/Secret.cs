using System;
using System.Configuration;
using System.IO;

namespace SignUp.Model
{
    public class Secret
    {
        public static string DbConnectionString 
        { 
            get 
            { 
                var path = Config.DbConnectionStringPath; 
                if (!File.Exists(path))
                {
                    throw new ConfigurationException($"Secret not found, path: {path}");
                }
                return File.ReadAllText(path);
            }
        }
    }
}