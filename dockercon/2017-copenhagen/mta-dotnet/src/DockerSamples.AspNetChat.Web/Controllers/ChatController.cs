using DockerSamples.AspNetChat.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DockerSamples.AspNetChat.Web.Controllers
{
    public class ChatController : Controller
    {
        public ActionResult Login()
        {
            return View("Login");
        }

        [HttpPost]
        public ActionResult Login(UserViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }
            return View("Index", model);
        }

        public ActionResult Index(UserViewModel model)
        {
            return View();
        }
    }
}