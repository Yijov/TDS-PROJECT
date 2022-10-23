using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using NetCoreApi_5.Models;

namespace NetCoreApi_5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserModelsController : ControllerBase
    {
        private UserManager<UserModel> _userManager;
        private SignInManager<UserModel> _singInManager;

        public UserModelsController(UserManager<UserModel> userManager, SignInManager<UserModel> singInManager)
        {
            _userManager = userManager;
            _singInManager = singInManager;
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
    }
}
