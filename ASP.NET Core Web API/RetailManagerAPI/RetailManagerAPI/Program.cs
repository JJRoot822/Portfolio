using Microsoft.EntityFrameworkCore;
using RetailManagerAPI.Database;
using RetailManagerAPI.Controllers;

namespace RetailManagerAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.

            builder.Services.AddControllers();

            builder.Services.AddDbContext<AuthenticationContext>(
                options => options.UseSqlServer(
                    builder.Configuration.GetConnectionString("AuthConnectionString")
                )
            );

            var app = builder.Build();

            // Configure the HTTP request pipeline.

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

                        
            app.Run();
        }
    }
}