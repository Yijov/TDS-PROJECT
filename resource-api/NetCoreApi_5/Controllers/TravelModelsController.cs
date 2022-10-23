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
    public class TravelModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public TravelModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/TravelModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TravelModelApi>>> GetTravelModel()
        {
            return await _context.TravelModel.Select(model => new TravelModelApi() 
            { 
            
                Id_Tavel = model.Id_Tavel,
                Id_Road = model.Id_Road,
                Id_User = model.Id_User,
                Time = model.Time,
            
            }).ToListAsync();
        }

        // GET: api/TravelModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TravelModelApi>> GetTravelModel(int id)
        {
            var travelModel = await _context.TravelModel.FindAsync(id);

            var _travelModel = travelModel != null ? new TravelModelApi() 
            {
                Id_Tavel = travelModel.Id_Tavel,
                Id_Road = travelModel.Id_Road,
                Id_User = travelModel.Id_User,
                Time = travelModel.Time,
            } : null;

            if (_travelModel == null)
            {
                return NotFound();
            }

            return _travelModel;
        }

        // PUT: api/TravelModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTravelModel(int id, TravelModelApi travelModel)
        {
            if (id != travelModel.Id_Tavel)
            {
                return BadRequest();
            }

            TravelModel data = new TravelModel()
            {
                Id_Tavel = travelModel.Id_Tavel,
                Id_Road = travelModel.Id_Road,
                Id_User = travelModel.Id_User,
                Time = travelModel.Time,
            }; 

            _context.Entry(data).State = EntityState.Modified;

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
        public async Task<ActionResult<TravelModelApi>> PostTravelModel(TravelModelApi travelModel)
        {

            TravelModel data = new TravelModel() 
            {
                Id_Tavel = travelModel.Id_Tavel,
                Id_Road = travelModel.Id_Road,
                Id_User = travelModel.Id_User,
                Time = travelModel.Time,
            };

            _context.TravelModel.Add(data);
            await _context.SaveChangesAsync();
            travelModel.Id_Tavel = data.Id_Tavel;

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
