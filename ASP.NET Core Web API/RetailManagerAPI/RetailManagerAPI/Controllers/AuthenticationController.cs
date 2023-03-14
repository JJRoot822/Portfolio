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
        
    }
}
