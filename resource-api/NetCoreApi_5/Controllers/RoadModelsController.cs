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
    public class RoadModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public RoadModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/RoadModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RoadModel>>> GetRoadModel()
        {
            return await _context.RoadModel.ToListAsync();
        }

        // GET: api/RoadModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RoadModel>> GetRoadModel(int id)
        {
            var roadModel = await _context.RoadModel.FindAsync(id);

            if (roadModel == null)
            {
                return NotFound();
            }

            return roadModel;
        }

        // PUT: api/RoadModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRoadModel(int id, RoadModel roadModel)
        {
            if (id != roadModel.Id_Road)
            {
                return BadRequest();
            }

            _context.Entry(roadModel).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RoadModelExists(id))
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

        // POST: api/RoadModels
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<RoadModel>> PostRoadModel(RoadModel roadModel)
        {
            _context.RoadModel.Add(roadModel);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetRoadModel", new { id = roadModel.Id_Road }, roadModel);
        }

        // DELETE: api/RoadModels/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRoadModel(int id)
        {
            var roadModel = await _context.RoadModel.FindAsync(id);
            if (roadModel == null)
            {
                return NotFound();
            }

            _context.RoadModel.Remove(roadModel);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool RoadModelExists(int id)
        {
            return _context.RoadModel.Any(e => e.Id_Road == id);
        }
    }
}
