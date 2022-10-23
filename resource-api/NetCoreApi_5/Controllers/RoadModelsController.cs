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
    public class RoadModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public RoadModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/RoadModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<RoadModelApi>>> GetRoadModel()
        {
            return await _context.RoadModel.Select(model => new RoadModelApi() 
            { 
                Id_Road = model.Id_Road,
                Description = model.Description,
                Time = model.Time,
                Id_User = model.Id_User,
            }).ToListAsync();
        }

        // GET: api/RoadModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<RoadModelApi>> GetRoadModel(int id)
        {
            var roadModel = await _context.RoadModel.FindAsync(id);

            var _roadModel = roadModel != null ? new RoadModelApi() 
            {
                Id_Road = roadModel.Id_Road,
                Description = roadModel.Description,
                Time = roadModel.Time,
                Id_User = roadModel.Id_User,
            } : null;

            if (_roadModel == null)
            {
                return NotFound();
            }

            return _roadModel;
        }

        // PUT: api/RoadModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutRoadModel(int id, RoadModelApi roadModel)
        {
            if (id != roadModel.Id_Road)
            {
                return BadRequest();
            }

            RoadModel data = new RoadModel() 
            {
                Id_Road = roadModel.Id_Road,
                Description = roadModel.Description,
                Time = roadModel.Time,
                Id_User = roadModel.Id_User,
            };

            _context.Entry(data).State = EntityState.Modified;

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
        public async Task<ActionResult<RoadModelApi>> PostRoadModel(RoadModelApi roadModel)
        {
            RoadModel data = new RoadModel()
            {
                Id_Road = roadModel.Id_Road,
                Description = roadModel.Description,
                Time = roadModel.Time,
                Id_User = roadModel.Id_User,
            };

            _context.RoadModel.Add(data);
            await _context.SaveChangesAsync();
            roadModel.Id_Road = data.Id_Road;

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
