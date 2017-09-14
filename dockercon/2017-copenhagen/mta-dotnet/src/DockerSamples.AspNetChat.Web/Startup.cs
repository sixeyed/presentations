using Owin;
using Microsoft.Owin;
using System.Configuration;
using Microsoft.AspNet.SignalR;
using DockerSamples.AspNetChat.Web.Hubs;

[assembly: OwinStartup(typeof(DockerSamples.AspNetChat.Web.Startup))]

namespace DockerSamples.AspNetChat.Web
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SignalR-Backbone"].ConnectionString;            
            GlobalHost.DependencyResolver.UseSqlServer(connectionString);
            app.MapSignalR();
        }
    }
}