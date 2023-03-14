using Microsoft.AspNetCore.Mvc;

using RetailManagerAPI.Database;
using RetailManagerAPI.Database.Models;

namespace RetailManagerAPI.Controllers;

[Route("api/account")]
[ApiController]
public class UserAccountController : ControllerBase
{
    // GET: api/<UserAccountController>
    [HttpGet]
    public IEnumerable<string> Get()
    {
        return new string[] { "value1", "value2" };
    }

    // GET api/<UserAccountController>/5
    [HttpGet("{id}")]
    public string Get(int id)
    {
        return "value";
    }

    // POST api/<UserAccountController>
    [HttpPost]
    public void Post([FromBody] string value)
    {
    }

    // PUT api/<UserAccountController>/5
    [HttpPut("{id}")]
    public void Put(int id, [FromBody] string value)
    {
    }

    // DELETE api/<UserAccountController>/5
    [HttpDelete("{id}")]
    public void Delete(int id)
    {
    }
}
