CREATE DATABASE BulletinBoard;
GO

USE BulletinBoard;

CREATE TABLE Events (
  Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  Title NVARCHAR(50),
  Detail NVARCHAR(200),
  [Date] DATETIMEOFFSET,
  CreatedAt DATETIMEOFFSET NOT NULL, 
  UpdatedAt DATETIMEOFFSET NOT NULL
);

INSERT INTO Events (Title, Detail, [Date], CreatedAt, UpdatedAt) VALUES
(N'Future Decoded - Practice', N'Prep for FD keynote & demos', '2017-10-31', GETDATE(), GETDATE()),
(N'Future Decoded - Day 1', N'The Open Cloud', '2017-10-31', GETDATE(), GETDATE()),
(N'Future Decoded - Day 2', N'Technical Deep Dive', '2017-11-01', GETDATE(), GETDATE());

SELECT * FROM BulletinBoard.dbo.Events;