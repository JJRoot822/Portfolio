using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RetailManagerAPI.Migrations
{
    /// <inheritdoc />
    public partial class TypoFix : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_Rroles_RoleId",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Rroles",
                table: "Rroles");

            migrationBuilder.RenameTable(
                name: "Rroles",
                newName: "roles");

            migrationBuilder.AddPrimaryKey(
                name: "PK_roles",
                table: "roles",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_roles_RoleId",
                table: "Users",
                column: "RoleId",
                principalTable: "roles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Users_roles_RoleId",
                table: "Users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_roles",
                table: "roles");

            migrationBuilder.RenameTable(
                name: "roles",
                newName: "Rroles");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Rroles",
                table: "Rroles",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Users_Rroles_RoleId",
                table: "Users",
                column: "RoleId",
                principalTable: "Rroles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
