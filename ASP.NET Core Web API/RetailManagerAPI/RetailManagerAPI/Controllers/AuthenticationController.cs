using Microsoft.AspNetCore.Mvc;

using RetailManagerAPI.Database;
using RetailManagerAPI.Database.Models;
using RetailManagerAPI.ResponseModels;
using RetailManagerAPI.Security;
using RetailManagerAPI.RequestBodyModels;

namespace RetailManagerAPI.Controllers;

[Route("api/login")]
[ApiController]
public class AuthenticationController : ControllerBase
{
    private readonly AuthenticationContext AuthContext;

    public AuthenticationController(AuthenticationContext AuthContext)
    {
        this.AuthContext = AuthContext;
    }
    
    [HttpPost]
    public AuthResponse Post([FromBody] AuthBody body)
    {
        List<User> users = AuthContext.Users.Where(
            u => u.Email == body.Email && u.Username == body.Username
        ).ToList();

        int userCount = users.ToArray().Length;
        
        if (userCount > 0) 
        {
            User user = users.ElementAt(0);

            if (SecurityUtil.DoPasswordsMatch(body.Password, user.Password))
            {
                return new AuthResponse { WasSuccessful = true, LoggedInUser = user }
            }

            return new AuthResponse { WasSuccessful = false, LoggedInUser = null };
        }

        return new AuthResponse { WasSuccessful = false, LoggedInUser = null };
    }
}
