using SignUp.Web.Logging;
using SignUp.Web.Model;
using System;
using System.Diagnostics;
using System.Web.UI;

namespace SignUp.Web
{
    public partial class _Default : Page
    {
        protected void Insert(object sender, EventArgs e)
        {
            var evt = new Event
            {
                Title = this.txtTitle.Text,
                Detail = this.txtDetail.Text,
                Date = this.calDate.SelectedDate,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now
            };

            Log.Info("Saving new event, title: {0}", this.txtTitle.Text);
            var stopwatch = Stopwatch.StartNew();

            using (var context = new BulletinBoardEntities())
            {
                context.AddToEvents(evt);
                context.SaveChanges();
            }
            Log.Info("Event saved, title: {0}, ID: {1}, took: {2}ms", evt.Title, evt.Id, stopwatch.ElapsedMilliseconds);

            Server.Transfer("Default.aspx");
        }
    }
}