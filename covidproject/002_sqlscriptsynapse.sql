IF OBJECT_ID('dbo.Watermark', 'U') IS NOT NULL
    DROP TABLE dbo.Watermark;
GO

CREATE TABLE dbo.Watermark
(
    TableName VARCHAR(200) NOT NULL,
    LastID    INT          NULL
);
GO



IF OBJECT_ID('bronze1.Patient', 'U') IS NOT NULL
    DROP TABLE bronze1.Patient;
GO

CREATE TABLE bronze1.Patient
(
    PatientID   INT           NOT NULL,
    FirstName   VARCHAR(50)   NOT NULL,
    LastName    VARCHAR(50)   NOT NULL,
    DateOfBirth DATE          NOT NULL,
    Gender      VARCHAR(10)   NOT NULL
);
GO

-- To create staging table
-- SELECT * INTO bronze1.staging_Patient FROM bronze1.Patient Where 1=0;

-- SELECT * FROM dbo.Patient WHERE PatieintID > MAXID From Watermark Table for Patient table;

-- STORED PROC to merge staging to main    
IF OBJECT_ID('bronze1.usp_merge_patient', 'P') IS NOT NULL
    DROP PROCEDURE bronze1.usp_merge_patient;
GO

CREATE PROCEDURE bronze1.usp_merge_patient
AS
BEGIN
    SET NOCOUNT ON;

    -- Update existing rows
    UPDATE tgt
    SET
        tgt.FirstName   = src.FirstName,
        tgt.LastName    = src.LastName,
        tgt.DateOfBirth = src.DateOfBirth,
        tgt.Gender      = src.Gender
    FROM bronze1.patient AS tgt
    INNER JOIN bronze1.staging_patient AS src
        ON tgt.PatientID = src.PatientID;

    -- Insert new rows
    INSERT INTO bronze1.patient
    (
        PatientID,
        FirstName,
        LastName,
        DateOfBirth,
        Gender
    )
    SELECT
        src.PatientID,
        src.FirstName,
        src.LastName,
        src.DateOfBirth,
        src.Gender
    FROM bronze1.staging_patient AS src
    LEFT JOIN bronze1.patient AS tgt
        ON tgt.PatientID = src.PatientID
    WHERE tgt.PatientID IS NULL;

DROP TABLE bronze1.staging_patient;

END;
GO
