using SignUp.Entities;
using System.Data.Entity;

namespace SignUp.Model
{
    public class SignUpContext : DbContext
    {
        public SignUpContext() : base(Config.DbConnectionString) { }

        public DbSet<Country> Countries { get; set; }

        public DbSet<Role> Roles { get; set; }

        public DbSet<Prospect> Prospects { get; set; }

        protected override void OnModelCreating(DbModelBuilder builder)
        {
            builder.Entity<Country>().HasKey(c => c.CountryCode);
            builder.Entity<Role>().HasKey(r => r.RoleCode);
            builder.Entity<Prospect>().HasOptional<Country>(p => p.Country);
            builder.Entity<Prospect>().HasOptional<Role>(p => p.Role);            
        }        
    }
}
