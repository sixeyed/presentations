using SignUp.Entities;
using SignUp.Messaging;
using SignUp.Messaging.Messages.Events;
using SignUp.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SignUp.Web
{
    public partial class SignUp : Page
    {
        private static Dictionary<string, Country> _Countries;
        private static Dictionary<string, Role> _Roles;

        public static void PreloadStaticDataCache()
        {
            _Countries = new Dictionary<string, Country>();
            _Roles = new Dictionary<string, Role>();
            using (var context = new SignUpContext())
            {
                _Countries["-"] = context.Countries.Single(x => x.CountryCode == "-");
                foreach (var country in context.Countries.Where(x=>x.CountryCode != "-").OrderBy(x => x.CountryName))
                {
                    _Countries[country.CountryCode] = country;
                }

                _Roles["-"] = context.Roles.Single(x => x.RoleCode == "-");
                foreach (var role in context.Roles.Where(x => x.RoleCode != "-").OrderBy(x => x.RoleName))
                {
                    _Roles[role.RoleCode] = role;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                PopulateRoles();
                PopulateCountries();
            }
        }

        private void PopulateRoles()
        {
            ddlRole.Items.Clear();
            ddlRole.Items.AddRange(_Roles.Select(x => new ListItem(x.Value.RoleName, x.Key)).ToArray()); 
        }

        private void PopulateCountries()
        {
            ddlCountry.Items.Clear();
            ddlCountry.Items.AddRange(_Countries.Select(x => new ListItem(x.Value.CountryName, x.Key)).ToArray());
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            var country = _Countries[ddlCountry.SelectedValue];
            var role = _Roles[ddlRole.SelectedValue];

            var prospect = new Prospect
            {
                CompanyName = txtCompanyName.Text,
                EmailAddress = txtEmail.Text,
                FirstName = txtFirstName.Text,
                LastName = txtLastName.Text,
                Country = country,
                Role = role
            };

            //v1:
            //using (var context = new SignUpContext())
            //{
            //    //reload child objects:
            //    prospect.Country = context.Countries.Single(x => x.CountryCode == prospect.Country.CountryCode);
            //    prospect.Role = context.Roles.Single(x => x.RoleCode == prospect.Role.RoleCode);

            //    context.Prospects.Add(prospect);
            //    context.SaveChanges();
            //}

            //v2:
            var eventMessage = new ProspectSignedUpEvent
            {
                Prospect = prospect,
                SignedUpAt = DateTime.UtcNow
            };

            MessageQueue.Publish(eventMessage);

            Server.Transfer("ThankYou.aspx");
        }
    }
}