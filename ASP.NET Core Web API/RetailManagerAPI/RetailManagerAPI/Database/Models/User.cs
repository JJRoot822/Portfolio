using System.ComponentModel.DataAnnotations;

namespace RetailManagerAPI.Database.Models;

public class User
{
    public int Id { get; set; }

    [Required]
    public string FirstName { get; set; }

    [Required]
    public string LastName { get; set; }

    [Required]
    public string Username { get; set; }
    public string Email { get; set; }
    public DateOnly BirthDate { get; set; }

    [Required]
    public string Password { get; set; }


    [Required]
    public int RoleId { get; set; }
    public Role role { get; set; }
}
