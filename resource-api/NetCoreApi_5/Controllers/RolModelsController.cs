using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetCoreApi_5.Models;
using NetCoreApi_5.ModelsApi;

namespace NetCoreApi_5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class RolModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public RolModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/RolModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RolModelApi>>> GetRolModel()
        {
            return await _context.RolModel.Select(model => new RolModelApi() 
            { 
                Id_Rol = model.Id_Rol,
                Description = model.Description,
            }).ToListAsync();
        }

        // GET: api/RolModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RolModelApi>> GetRolModel(int id)
        {
            var rolModel = await _context.RolModel.FindAsync(id);

            var _rolModel = rolModel != null ? new RolModelApi() 
            { 
                Id_Rol = rolModel.Id_Rol,
                Description = rolModel.Description,
            } : null;

            if (_rolModel == null)
            {
                return NotFound();
            }

            return _rolModel;
        }

        // PUT: api/RolModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRolModel(int id, RolModelApi rolModel)
        {
            if (id != rolModel.Id_Rol)
            {
                return BadRequest();
            }

            RolModel data = new RolModel()
            {
                Id_Rol = rolModel.Id_Rol,
                Description = rolModel.Description,
            };

            _context.Entry(data).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RolModelExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/RolModels
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<RolModelApi>> PostRolModel(RolModelApi rolModel)
        {

            RolModel data = new RolModel()
            {
                Id_Rol = rolModel.Id_Rol,
                Description = rolModel.Description,
            }; 

            _context.RolModel.Add(data);
            await _context.SaveChangesAsync();
            rolModel.Id_Rol = data.Id_Rol;

            return CreatedAtAction("GetRolModel", new { id = rolModel.Id_Rol }, rolModel);
        }

        // DELETE: api/RolModels/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRolModel(int id)
        {
            var rolModel = await _context.RolModel.FindAsync(id);
            if (rolModel == null)
            {
                return NotFound();
            }

            _context.RolModel.Remove(rolModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RolModelExists(int id)
        {
            return _context.RolModel.Any(e => e.Id_Rol == id);
        }
    }
}
