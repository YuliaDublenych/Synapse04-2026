IF OBJECT_ID('dbo.Patient', 'U') IS NOT NULL
    DROP TABLE dbo.Patient;
GO

CREATE TABLE dbo.Patient
(
    PatientID   INT           NOT NULL PRIMARY KEY,
    FirstName   VARCHAR(50)   NOT NULL,
    LastName    VARCHAR(50)   NOT NULL,
    DateOfBirth DATE          NOT NULL,
    Gender      VARCHAR(10)   NOT NULL
);
GO

INSERT INTO dbo.Patient (PatientID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(1, 'John',   'Smith',   '1985-03-12', 'Male'),
(2, 'Emma',   'Johnson', '1992-07-25', 'Female'),
(3, 'Liam',   'Brown',   '1978-11-08', 'Male'),
(4, 'Olivia', 'Davis',   '2001-01-19', 'Female'),
(5, 'Noah',   'Wilson',  '1990-09-30', 'Male'),
(6, 'Ava',    'Taylor',  '1988-05-14', 'Female');
GO

SELECT * 
FROM dbo.Patient;
GO
