using System;
using Microsoft.EntityFrameworkCore;
using RMDataAccess.Models;

namespace RMDataAccess
{
    public class UserContext : DbContext
    {
        public DbSet<User> users { get; set; }

        public UserContext(DbContextOptions<UserContext> options) : base(options)
        {
            
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySQL(DBUtil.AuthConnectionString);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            
        }
    }
}
