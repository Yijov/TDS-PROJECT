using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NetCoreApi_5.Models;

namespace NetCoreApi_5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TravelModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public TravelModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/TravelModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TravelModel>>> GetTravelModel()
        {
            return await _context.TravelModel.ToListAsync();
        }

        // GET: api/TravelModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TravelModel>> GetTravelModel(int id)
        {
            var travelModel = await _context.TravelModel.FindAsync(id);

            if (travelModel == null)
            {
                return NotFound();
            }

            return travelModel;
        }

        // PUT: api/TravelModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTravelModel(int id, TravelModel travelModel)
        {
            if (id != travelModel.Id_Tavel)
            {
                return BadRequest();
            }

            _context.Entry(travelModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TravelModelExists(id))
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

        // POST: api/TravelModels
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<TravelModel>> PostTravelModel(TravelModel travelModel)
        {
            _context.TravelModel.Add(travelModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTravelModel", new { id = travelModel.Id_Tavel }, travelModel);
        }

        // DELETE: api/TravelModels/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTravelModel(int id)
        {
            var travelModel = await _context.TravelModel.FindAsync(id);
            if (travelModel == null)
            {
                return NotFound();
            }

            _context.TravelModel.Remove(travelModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TravelModelExists(int id)
        {
            return _context.TravelModel.Any(e => e.Id_Tavel == id);
        }
    }
}
