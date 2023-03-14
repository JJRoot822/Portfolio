using Microsoft.EntityFrameworkCore;

using RetailManagerAPI.Database.Models;

namespace RetailManagerAPI.Database;

public class DBUtil
{
    public static async Task<List<User>> GetAllUsers(AuthenticationContext context)
    {
        return await context.Users.ToListAsync();
    }

    public static async Task<User> GetUserById(AuthenticationContext context, int Id)
    {
        return await context.Users.FindAsync(Id);
    }  

    public static async Task<User> GetUserByEmailAndUsername(AuthenticationContext context, string email, string username)
    {
        return await context.Users.FirstOrDefaultAsync(
            u => u.Email == email && u.Username == username
        );
    }

    public static Task<List<Role>> GetAllRoles(AuthenticationContext context)
    {
        context.roles.ToListAsync();
    }

    public static async Task<Role> GetUserRoleById(AuthenticationContext context, int id)
    {
        return await context.roles.FindAsync(id);
    }

    public static async Task<Role> GetRoleForUserById(AuthenticationContext context, int id)
    {
        return await context.Users.FindAsync(id).Role;
    }
    public static async Task CreateUser(AuthenticationContext context, User user)
    {
        await context.Users.AddAsync(user);
        await context.SaveChangesAsync();
    }

    public static async Task CreateUserRole(AuthenticationContext context, Role role)
    {
        await context.roles.AddAsync(role);
        await context.SaveChangesAsync();
    }

    public static async Task UpdatePassword(AuthenticationContext context, int id, string newPassword)
    {
        User user = await GetUserById(context, id);
        user.Password = newPassword;

        await context.SaveChangesAsync();
    }

    public static async Task UpdateUserRole(AuthenticationContext context, int id, string newRoleName)
    {
        Role role = await GetUserRoleById(context, id);
        role.Name = newRoleName;

        await context.SaveChangesAsync();
    }

    public static async Task DeleteUser(AuthenticationContext context, int id)
    {
        User user = await GetUserById(id);

        context.Users.Remove(user);

        await context.SaveChangesAsync();
    }

    public static async Task DeleteUserRole(AuthenticationContext context, int id)
    {
        Role role = await GetUserRoleById(id);

        context.roles.Remove(role);

        await context.SaveChangesAsync();
    }
}
