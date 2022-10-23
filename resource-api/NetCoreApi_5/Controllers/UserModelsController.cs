using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using NetCoreApi_5.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Text;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.Extensions.Options;

namespace NetCoreApi_5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserModelsController : ControllerBase
    {
        private UserManager<UserModel> _userManager;
        private SignInManager<UserModel> _singInManager;
        private readonly AppContext5 _context;
        private readonly AppSettings _appSettings;

        public UserModelsController(UserManager<UserModel> userManager, SignInManager<UserModel> singInManager, AppContext5 context, IOptions<AppSettings> appSettings)
        {
            _userManager = userManager;
            _singInManager = singInManager;
            _context = context;
            _appSettings = appSettings.Value;
        }

        [HttpPost]
        [Route("Register")]
        //POST : api/UserModel/Register
        public async Task<object> PostUserModel(UserPostModel model) 
        {

            var userModel = new UserModel()
            {
                Name = model.Name,

                User_Name = model.User_Name,
                UserName = model.User_Name,

                Student_Code = model.Student_Code,

                Ident_Card = model.Ident_Card,

                Password = model.Password,

                Id_Rol = model.Id_Rol,
            };

            try
            {
                var result = await _userManager.CreateAsync(userModel, model.Password);
                return Ok(result);
            }
            catch (Exception ex) 
            {
                throw ex;
            }
        }

        [HttpGet]
        [Route("GetRegister")]
        //GET: api/UserModel/GetRegister
        public async Task<ActionResult<IEnumerable<UserPostModel>>> GetUserModels() 
        {

            return await _context.UserModel.Select(model => new UserPostModel()
            {

                Name = model.Name,
                User_Name = model.UserName,
                Student_Code = model.Student_Code,
                Ident_Card = model.Ident_Card,
                Password = model.Password,
                Id_Rol = model.Id_Rol,

            }).ToListAsync();
        }

        [HttpPost]
        [Route("Login")]
        //POST : api/UserModel/Login
        public async Task<IActionResult> Login(LoginModel model) 
        {
            var user = await _userManager.FindByNameAsync(model.UserName);

            if (user != null && await _userManager.CheckPasswordAsync(user, model.Password))
            {
                var tokenDescriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim("UserID", user.Id.ToString())
                    }),
                    Expires = DateTime.UtcNow.AddHours(2),
                    SigningCredentials = new SigningCredentials
                    (
                        new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_appSettings.JWT_Secret)), SecurityAlgorithms.HmacSha256Signature
                    ),
                };
                var tokenHandler = new JwtSecurityTokenHandler();
                var securityToken = tokenHandler.CreateToken(tokenDescriptor);
                var token = tokenHandler.WriteToken(securityToken);

                return Ok(new { token });

            }
            else {
                return BadRequest( new { message = "Usuario o contraseña invalida"} );
            }
        }
    }
}
