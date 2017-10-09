using System.ComponentModel.DataAnnotations;

namespace DockerSamples.AspNetChat.Web.Models
{
    public class UserViewModel
    {
        [Required]
        [Display(Name = "Name")]
        public string Name { get; set; }
    }
}