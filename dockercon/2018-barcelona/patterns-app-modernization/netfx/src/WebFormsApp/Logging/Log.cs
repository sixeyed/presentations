using log4net;
using log4net.Appender;
using log4net.Config;

namespace WebFormsApp.Logging
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
                        if (_logger == null)
                        {
                            XmlConfigurator.Configure();
                            _logger = LogManager.GetLogger("WebFormsApp.Log");
                        }
                    }
                }
                return _logger;
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
        
        public static void Fatal(string format, params object[] args)
        {
            Logger.FatalFormat(format, args);
        }

        public static string GetAppenderName()
        {
            return GetFirstAppender().Name; 
        }

        private static IAppender GetFirstAppender()
        {
            return ((log4net.Repository.Hierarchy.Logger)(((log4net.Core.LoggerWrapperImpl)(_logger)).Logger)).Appenders[0];
        }

        public static string GetAppenderTarget()
        {
            IAppender appender = GetFirstAppender();

            if (appender.GetType() == typeof(RollingFileAppender))
            {
                return ((RollingFileAppender)appender).File;
            }           

            return "?";
        }

        public static string GetLogLevel()
        {
            return ((log4net.Repository.Hierarchy.Logger)(((log4net.Core.LoggerWrapperImpl)(_logger)).Logger)).EffectiveLevel.ToString();
        }
    }
}
