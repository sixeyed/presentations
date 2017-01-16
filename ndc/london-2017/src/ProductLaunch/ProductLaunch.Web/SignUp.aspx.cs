using ProductLaunch.Entities;
using ProductLaunch.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProductLaunch.Web
{
    public partial class SignUp : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateRoles();
            PopulateCountries();
        }

        private void PopulateRoles()
        {
            ddlRole.Items.Clear();
            using (var context = new ProductLaunchContext())
            {
                foreach (var role in context.Roles.OrderBy(x => x.RoleName))
                {
                    ddlRole.Items.Add(new ListItem(role.RoleName, role.RoleCode));
                }
            }
        }

        private void PopulateCountries()
        {
            ddlCountry.Items.Clear();
            using (var context = new ProductLaunchContext())
            {
                foreach (var country in context.Countries.OrderBy(x => x.CountryName))
                {
                    ddlCountry.Items.Add(new ListItem(country.CountryName, country.CountryCode));
                }
            }
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            using (var context = new ProductLaunchContext())
            {
                var country = context.Countries.Single(x => x.CountryCode == ddlCountry.SelectedValue);
                var role = context.Roles.Single(x => x.RoleCode == ddlRole.SelectedValue);

                var prospect = new Prospect
                {
                    CompanyName = txtCompanyName.Text,
                    EmailAddress = txtEmail.Text,
                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,
                    Country = country,
                    Role = role
                };

                context.Prospects.Add(prospect);
                context.SaveChanges();
            }
        }
    }
}