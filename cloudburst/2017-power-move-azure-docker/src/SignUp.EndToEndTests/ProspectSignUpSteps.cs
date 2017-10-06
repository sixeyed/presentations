using NUnit.Framework;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;
using SimpleBrowser.WebDriver;
using System;
using System.Data.SqlClient;
using System.Threading;
using TechTalk.SpecFlow;

namespace SignUp.EndToEndTests
{
    [Binding]
    public class ProspectSignUpSteps
    {
        private static IWebDriver _Driver;
        private string _emailAddress;

        [BeforeFeature]
        public static void Setup()
        {
            _Driver = new SimpleBrowserDriver();
        }

        [AfterFeature]
        public static void TearDown()
        {
            _Driver.Close();
            _Driver.Dispose();
        }

        [Given(@"I browse to the Sign Up Page at ""(.*)""")]
        public void GivenIBrowseToTheSignUpPageAt(string url)
        {
            _Driver.Navigate().GoToUrl(url);
        }

        [Given(@"I enter details '(.*)' '(.*)' '(.*)' '(.*)' '(.*)' '(.*)'")]
        public void GivenIEnterDetails(string firstName, string lastName, string emailAddress,
                                       string companyName, string country, string role)
        {
            _Driver.FindElement(By.Id("MainContent_txtFirstName")).SendKeys(firstName);
            _Driver.FindElement(By.Id("MainContent_txtLastName")).SendKeys(lastName);
            _Driver.FindElement(By.Id("MainContent_txtEmail")).SendKeys(emailAddress);
            _Driver.FindElement(By.Id("MainContent_txtCompanyName")).SendKeys(companyName);

            new SelectElement(_Driver.FindElement(By.Id("MainContent_ddlCountry"))).SelectByText(country);
            new SelectElement(_Driver.FindElement(By.Id("MainContent_ddlRole"))).SelectByText(role);

            _emailAddress = emailAddress;
        }

        [When(@"I press Go")]
        public void WhenIPressGo()
        {
            var goButton = _Driver.FindElement(By.Id("MainContent_btnGo"));
            goButton.Click();
        }

        [Then(@"I should see the Thank You page")]
        public void ThenIShouldSeeTheThankYouPage()
        {
            Assert.AreEqual("Ta", _Driver.Title.Trim());
        }

        [Then(@"my details should be saved")]
        public void ThenMyDetailsShouldBeSaved()
        {
            AssertHelper.RetryAssert(50, 40, $"Email address: {_emailAddress} not found", () =>
            {
                var count = 0;
                var connectionString = Environment.GetEnvironmentVariable("DB_CONNECTION_STRING");
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (var command = connection.CreateCommand())
                    {
                        command.CommandText = $"SELECT COUNT(*) FROM Prospects WHERE EmailAddress = '{_emailAddress}'";
                        count = (int)command.ExecuteScalar();
                    }
                }
                return count > 0;
            });
         }
    }
}
