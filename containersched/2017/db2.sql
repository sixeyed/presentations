
SELECT *
FROM sys.tables

SELECT * 
FROM Countries

SELECT * 
FROM Prospects

INSERT INTO Prospects(
     FirstName, 
     LastName, 
     CompanyName, 
     EmailAddress, 
     Country_CountryCode, 
     Role_RoleCode
)
VALUES (
    'Elton',
    'Stoneman',
    'Docker, Inc.',
    'elton@docker.com',
    'GBR',
    'DA'
)