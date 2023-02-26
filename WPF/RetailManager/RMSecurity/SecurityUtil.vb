Imports System.Security.Cryptography
Imports System.Text

Public Class SecurityUtil
    Public Function HashPassword(ByVal password As String) As String
        Dim salt As String = GenerateSalt()
        Dim bytesToHash() As Byte = Encoding.UTF8.GetBytes(password & salt)
        Dim hashBytes() As Byte = New SHA512Managed().ComputeHash(bytesToHash)
        Dim hashWithSaltBytes() As Byte = hashBytes.Concat(Encoding.UTF8.GetBytes(salt)).ToArray()
        Dim hashedPassword As String = Convert.ToBase64String(hashWithSaltBytes)

        While hashedPassword.Length < 256
            bytesToHash = Encoding.UTF8.GetBytes(hashedPassword & salt)
            hashBytes = New SHA512Managed().ComputeHash(bytesToHash)
            hashWithSaltBytes = hashBytes.Concat(Encoding.UTF8.GetBytes(salt)).ToArray()
            hashedPassword = Convert.ToBase64String(hashWithSaltBytes)
        End While

        Return hashedPassword
    End Function

    Public Function VerifyPassword(ByVal password As String, ByVal hashedPassword As String) As Boolean
        Dim bytesToHash() As Byte = Convert.FromBase64String(hashedPassword)
        Dim salt As String = Encoding.UTF8.GetString(bytesToHash, 64, bytesToHash.Length - 64)
        Dim inputHashBytes() As Byte = New SHA512Managed().ComputeHash(Encoding.UTF8.GetBytes(password & salt))
        Dim inputHashWithSaltBytes() As Byte = inputHashBytes.Concat(Encoding.UTF8.GetBytes(salt)).ToArray()
        Dim inputHashedPassword As String = Convert.ToBase64String(inputHashWithSaltBytes)

        Return String.Compare(hashedPassword, inputHashedPassword) = 0
    End Function

    Private Function GenerateSalt() As String
        Dim saltBytes(15) As Byte
        Dim rngCryptoServiceProvider As New RNGCryptoServiceProvider()
        rngCryptoServiceProvider.GetBytes(saltBytes)
        Return Convert.ToBase64String(saltBytes)
    End Function
End Class
