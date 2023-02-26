using System.Security.Cryptography;

namespace RMSecurity
{
    public static class SecurityUtil
    {
        public static string HashPassword(string password)
        {
            byte[] salt;
            byte[] bytes;

            using (var rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, 64, 350000))
            {
                salt = rfc2898DeriveBytes.Salt;
                bytes = rfc2898DeriveBytes.GetBytes(256 / 8);
            }

            var stringBuilder = new StringBuilder(512);
            stringBuilder.Append(Convert.ToBase64String(salt));
            stringBuilder.Append(Convert.ToBase64String(bytes));

            return stringBuilder.ToString();
        }

        public static bool DoPasswordsMatch(string password, string hashedPassword)
        {
            var saltBytes = Convert.FromBase64String(hashedPassword.Substring(0, 88));
            var hashBytes = Convert.FromBase64String(hashedPassword.Substring(88));

            using (var rfc2898DeriveBytes = new Rfc2898DeriveBytes(password, saltBytes, 350000))
            {
                var hashToCheck = rfc2898DeriveBytes.GetBytes(256 / 8);

                for (int i = 0; i < hashBytes.Length; i++)
                {
                    if (hashBytes[i] != hashToCheck[i])
                    {
                        return false;
                    }
                }
            }

            return true;
        }
    }
}