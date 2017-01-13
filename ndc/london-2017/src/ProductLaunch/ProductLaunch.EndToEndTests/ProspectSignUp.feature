Feature: Prospect Sign Up
	As a prospect interested in the product launch
	I want to sign up for notifications
	So that I can be updated with news

Scenario Outline: Sign Up with Valid Details
	Given I browse to the Sign Up Page at "172.20.251.110"
	And I enter details '<FirstName>' '<LastName>' '<EmailAddress>' '<CompanyName>' '<Country>' '<Role>'
	When I press Go
	Then I should see the Thank You page

Examples:
	| FirstName | LastName | EmailAddress           | CompanyName   | Country       | Role           |
	| Prospect  | A        | a.prospect@company.com | Company, Inc. | United States | Decision Maker |
	| Prospect  | B        | b.prospect@company.com | Company, Inc. | United Kingdom | Decision Maker |
	| Prospect  | C        | c.prospect@company.com | Company, Inc. | United States | Architect |
	| Prospect  | D        | d.prospect@company.com | Company, Inc. | United Kingdom | Decision Maker |
	| Prospect  | E        | e.prospect@company.com | Company, Inc. | United States | Architect |
	| Prospect  | F        | f.prospect@other.com | Other, Inc. | Sweden | Decision Maker |
