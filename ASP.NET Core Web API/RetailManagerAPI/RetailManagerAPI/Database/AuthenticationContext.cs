using Microsoft.EntityFrameworkCore;

namespace RetailManagerAPI.Database;

public class AuthenticationContext : DbContext
{
    public AuthenticationContext(DbContextOptions<AuthenticationContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {

    }
}
