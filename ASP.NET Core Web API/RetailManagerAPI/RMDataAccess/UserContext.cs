using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using RMDataAccess.Models;

namespace RMDataAccess
{
    class UserContext : DbContext
    {
        public DbSet<User> users { get; set; }

        public UserContext(DbContextOptions<UserContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            
        }
    }
}
