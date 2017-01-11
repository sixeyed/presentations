using ProductLaunch.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProductLaunch.Model
{
    public class ProductLaunchContext : DbContext
    {
        public ProductLaunchContext() : base("ProductLaunchDb") { }

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
