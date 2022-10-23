using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetCoreApi_5.Models;

namespace NetCoreApi_5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class PositionModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public PositionModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/PositionModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PositionModel>>> GetPositionModel()
        {
            return await _context.PositionModel.ToListAsync();
        }

        // GET: api/PositionModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PositionModel>> GetPositionModel(int id)
        {
            var positionModel = await _context.PositionModel.FindAsync(id);

            if (positionModel == null)
            {
                return NotFound();
            }

            return positionModel;
        }

        // PUT: api/PositionModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPositionModel(int id, PositionModel positionModel)
        {
            if (id != positionModel.Id_Position)
            {
                return BadRequest();
            }

            _context.Entry(positionModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PositionModelExists(id))
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

        // POST: api/PositionModels
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<PositionModel>> PostPositionModel(PositionModel positionModel)
        {
            _context.PositionModel.Add(positionModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPositionModel", new { id = positionModel.Id_Position }, positionModel);
        }

        // DELETE: api/PositionModels/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePositionModel(int id)
        {
            var positionModel = await _context.PositionModel.FindAsync(id);
            if (positionModel == null)
            {
                return NotFound();
            }

            _context.PositionModel.Remove(positionModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PositionModelExists(int id)
        {
            return _context.PositionModel.Any(e => e.Id_Position == id);
        }
    }
}
