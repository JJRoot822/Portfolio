using RetailManagerAPI.Database.Models;

namespace RetailManagerAPI.ResponseModels;

public class AuthResponse
{
    public bool WasSuccessful { get; set; }
    public User? LoggedInUser { get; set; }
}
