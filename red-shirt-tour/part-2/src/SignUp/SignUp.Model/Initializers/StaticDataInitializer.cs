using SignUp.Entities;
using System.Data.Entity;

namespace SignUp.Model.Initializers
{
    public class StaticDataInitializer : CreateDatabaseIfNotExists<SignUpContext>
    {
        protected override void Seed(SignUpContext context)
        {
            AddRole(context, "-", "--Not telling");
            AddRole(context, "DA", "Developer Advocate");
            AddRole(context, "DM", "Decision Maker");
            AddRole(context, "AC", "Architect");
            AddRole(context, "EN", "Engineer");
            AddRole(context, "OP", "IT Ops");

            AddCountry(context, "-", "--Not telling");
            AddCountry(context, "GBR", "United Kingdom");
            AddCountry(context, "USA", "United States");
            AddCountry(context, "PT", "Portugal");
            AddCountry(context, "NOR", "Norway");
            AddCountry(context, "SWE", "Sweden");
            AddCountry(context, "IRE", "Ireland");

            context.SaveChanges();
        }

        private void AddCountry(SignUpContext context, string code, string name)
        {
            context.Countries.Add(new Country
            {
                CountryCode = code,
                CountryName = name
            });
        }

        private void AddRole(SignUpContext context, string code, string name)
        {
            context.Roles.Add(new Role
            {
                RoleCode = code,
                RoleName = name
            });
        }
    }
}
