Deployment:


(1) Run Synapse Script 

(2) Deploy Pipeline using JSON file 

(3) Smoke Test: 
- First Run:
- Insert some rows into source table
```
INSERT INTO dbo.Patient (PatientID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(1, 'John',   'Smith',   '1985-03-12', 'Male'),
(2, 'Emma',   'Johnson', '1992-07-25', 'Female'),
(3, 'Liam',   'Brown',   '1978-11-08', 'Male'),
(4, 'Olivia', 'Davis',   '2001-01-19', 'Female'),
(5, 'Noah',   'Wilson',  '1990-09-30', 'Male'),
(6, 'Ava',    'Taylor',  '1988-05-14', 'Female');
GO
```
- Run the pipeline
- Check the bronze1.patient table in Synapse, and check the watermark.
```
Select * from dbo.patient -- run it in source

Select * from bronze1.patient -- run it in synapse
select * from dbo.watermark -- run it in synapse
```

- Subsequent Run:
- Insert some more rows into source table
```
INSERT INTO dbo.Patient (PatientID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(7, 'John',   'Smith',   '1985-03-12', 'Male'),
(8, 'Emma',   'Johnson', '1992-07-25', 'Female'),
(9, 'Liam',   'Brown',   '1978-11-08', 'Male')
```
- Run the pipeline again
- Check the bronze1.patient table in Synapse
```
Select * from dbo.patient -- run it in source

Select * from bronze1.patient -- run it in synapse
select * from dbo.watermark -- run it in synapse
```
