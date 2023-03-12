using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

using Microsoft.EntityFrameworkCore;

namespace RetailManagerAPI.Database.Models;

public class Role
{
    public int Id { get; set; }

    [Required]
    public string? Name { get; set; }

    public ICollection<User> users { get; set; }
}
