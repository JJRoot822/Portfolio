using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace RMDataAccess.Models
{
    [PrimaryKey("UserID")]
    public class User
    {
        public int UserID { get; set; }

        [Required]
        [MaxLength(75)]
        public string FirstName { get; set; }

        [Required]
        [MaxLength(75)]
        public string LastName { get; set; }

        [MaxLength(1)]
        public string? MiddleInitial { get; set; }

        [Required]
        [MaxLength(20)]
        public string Username { get; set; }

        [Required]
        [MaxLength(150)]
        public string EmailAddress { get; set; }

        [Required]
        [MaxLength(256)]
        public string Password { get; set; }
    }
}
