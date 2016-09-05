using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using PiWebApp.Math;
using PiWebApp.Models;

namespace PiWebApp.Controllers
{
    public class PiController : Controller
    {
        public IActionResult Index(int? dp = 6)
        {
            var stopwatch = Stopwatch.StartNew();
            HighPrecision.Precision = dp.Value;
            HighPrecision first = 4 * Atan.Calculate(5);
            HighPrecision second = Atan.Calculate(239);

            var pi = 4 * (first - second);

            var model = new PiModel
            {
                DecimalPlaces = dp.Value,
                Value = pi.ToString(),
                ComputeMilliseconds = stopwatch.ElapsedMilliseconds
            };

            return View(model);
        }
    }
}