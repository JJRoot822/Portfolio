using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace Buggernaut.Models.Domain;

public class ApplicationUser : IdentityUser
{
    [Required]
    [MaxLength(25)]
    [MinLength(20)]
    public string DisplayName { get; set; }
}
