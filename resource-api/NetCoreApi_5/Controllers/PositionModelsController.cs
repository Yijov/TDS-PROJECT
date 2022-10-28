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
    public class PositionModelsController : ControllerBase
    {
        private readonly AppContext5 _context;

        public PositionModelsController(AppContext5 context)
        {
            _context = context;
        }

        // GET: api/PositionModels
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PositionModelApi>>> GetPositionModel()
        {
            return await _context.PositionModel.Select(model => new PositionModelApi 
            { 
                Id_Position = model.Id_Position,
                Lat = model.Lat,
                Log = model.Log,
                Time = model.Time,
                Id_Travel = model.Id_Travel,
            }).ToListAsync();
        }

        // GET: api/PositionModels/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PositionModelApi>> GetPositionModel(int id)
        {
            var positionModel = await _context.PositionModel.FindAsync(id);

            var _positionModel = positionModel != null ? new PositionModelApi()
            {
                Id_Position = positionModel.Id_Position,
                Lat = positionModel.Lat,
                Log = positionModel.Log,
                Time = positionModel.Time,
                Id_Travel = positionModel.Id_Travel,
            } : null;

            if (_positionModel == null)
            {
                return NotFound();
            }

            return _positionModel;
        }

        // PUT: api/PositionModels/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPositionModel(int id, PositionModelApi positionModel)
        {
            if (id != positionModel.Id_Position)
            {
                return BadRequest();
            }

            PositionModel data = new PositionModel()
            {
                Id_Position = positionModel.Id_Position,
                Lat = positionModel.Lat,
                Log = positionModel.Log,
                Time = positionModel.Time,
                Id_Travel = positionModel.Id_Travel,
            };

            _context.Entry(data).State = EntityState.Modified;

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
        public async Task<ActionResult<PositionModelApi>> PostPositionModel(PositionModelApi positionModel)
        {
            PositionModel data = new PositionModel()
            {
                Id_Position = positionModel.Id_Position,
                Lat = positionModel.Lat,
                Log = positionModel.Log,
                Time = positionModel.Time,
                Id_Travel = positionModel.Id_Travel,
            };

            _context.PositionModel.Add(data);
            await _context.SaveChangesAsync();

            positionModel.Id_Position = data.Id_Position;
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
