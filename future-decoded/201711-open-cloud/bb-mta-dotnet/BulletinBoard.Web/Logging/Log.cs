using log4net;
using log4net.Config;
using System;

namespace SignUp.Web.Logging
{
    public static class Log
    {
        private static ILog _logger;
        private static object _syncLock = new object();

        private static ILog Logger
        {
            get
            {
                if (_logger == null)
                {
                    lock (_syncLock)
                    {
                        //use double-checked locking:
                        if (_logger == null)
                        {
                            XmlConfigurator.Configure();
                            _logger = LogManager.GetLogger("SignUp.Log");
                        }
                    }
                }
                return _logger;
            }
        }

        public static void Write(LogLevel logLevel, string format, params object[] args)
        {
            switch (logLevel)
            {
                case LogLevel.Debug:
                    if (Logger.IsDebugEnabled)
                    {
                        Debug(format, args);
                    }
                    break;
                case LogLevel.Error:
                    if (Logger.IsErrorEnabled)
                    {
                        Error(format, args);
                    }
                    break;
                case LogLevel.Fatal:
                    if (Logger.IsFatalEnabled)
                    {
                        Fatal(format, args);
                    }
                    break;
                case LogLevel.Info:
                    if (Logger.IsInfoEnabled)
                    {
                        Info(format, args);
                    }
                    break;
                case LogLevel.Warn:
                    if (Logger.IsWarnEnabled)
                    {
                        Warn(format, args);
                    }
                    break;
            }
        }

        public static void Debug(Func<string> logText)
        {
            if (Logger.IsDebugEnabled)
            {
                Logger.Debug(logText());
            }
        }
        
        public static void Debug(string format, params object[] args)
        {
            Logger.DebugFormat(format, args);
        }
        
        public static void Info(string format, params object[] args)
        {
            Logger.InfoFormat(format, args);
        }
        
        public static void Warn(string format, params object[] args)
        {
            Logger.WarnFormat(format, args);
        }
        
        public static void Error(string format, params object[] args)
        {
            Logger.ErrorFormat(format, args);
        }
        
        public static void Error(Exception ex, string format, params object[] args)
        {
            string message = string.Format(format, args);
            Logger.ErrorFormat("{0}. Exception: {1}", message, ex);
        }
        
        public static void Error(Exception ex)
        {
            Logger.Error(ex);
        }
        
        public static void Fatal(string format, object[] args)
        {
            Logger.FatalFormat(format, args);
        }
    }
}
