using Microsoft.EntityFrameworkCore;
using RetailManagerAPI.Database.Models;

namespace RetailManagerAPI.Database;

public class AuthenticationContext : DbContext
{
    public DbSet<User> Users { get; set; }
    public DbSet<Role>roles { get; set; }

    public AuthenticationContext(DbContextOptions<AuthenticationContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Role>().HasData(
            new Role { Id = 1, Name = "Administrator" },
            new Role { Id = 2, Name = "Manager"},
            new Role { Id = 3, Name = "IT Support" },
            new Role { Id = 4, Name = "Employee" }
        );
    }
}
