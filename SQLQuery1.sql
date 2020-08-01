CREATE TABLE StudentsInfo
(
StudentID int,
StudentName varchar(8000),
ParentName varchar(8000),
PhoneNumber bigint,
AdressOfStudent varchar(8000),
City varchar (8000),
Contry varchar(8000)
); --create a table with specific columns

ALTER TABLE StudentsInfo ADD BloodGroup varchar (8000); --add a new column in the table

ALTER TABLE StudentsInfo drop column BloodGroup; -- delete this column

INSERT INTO StudentsInfo VALUES ('07', 'Mario','Popa', '0761221231','Strada Riului numarul 14','Craiova','Romania'); -- insert new values in the table

sp_rename 'StudentsInfo', 'InfoStudents'; --rename the table

Alter Table StudentsInfo Add Check (Contry = 'Germany') --i check that the country is always Germany

 Alter Table StudentsInfo Add Constraint Default_City default 'Brasov' for City; --ad a default city

Create Index index_studentname on StudentsInfo(StudentName) -- create an index


Select * from StudentsInfo -- displays all record

UPDATE StudentsInfo set StudentName ='Ana', City ='Brasov'
Where StudentId = 4 -- updates the student's name and city for the Student with ID 4 in the StudentsInfo table

Delete FROM InfoStudents Where StudentName ='Ana' -- delete the record with the name Ana

Create TABLE SourceTable (StudentID int, StudentName varchar (8000), Marks int);
Create TABLE TargetTable (StudentID int, StudentName varchar (8000), Marks int);

INSERT INTO SourceTable VALUES ('1', 'Catalin', '90');
INSERT INTO SourceTable VALUES ('2', 'Maria', '92');
INSERT INTO SourceTable VALUES ('3', 'ALEX', '70');

INSERT INTO TargetTable VALUES ('1', 'Catalin', '90');
INSERT INTO TargetTable VALUES ('2', 'Maria', '80');
INSERT INTO TargetTable VALUES ('3', 'SARAH', '60');

MERGE TargetTable TARGET USING  SourceTable SOURCE ON (TARGET.StudentID = SOURCE.StudentID  )
 WHEN MATCHED AND TARGET.StudentName <> Source.StudentName OR TARGET.Marks <> Source.Marks
 THEN
 UPDATE SET TARGET.StudentName = Source.StudentName, TARGET.Marks = SOURCE.Marks
 WHEN NOT MATCHED BY TARGET THEN 
INSERT (StudentID,StudentName,Marks) VALUES (SOURCE.StudentID, SOURCE.StudentName, SOURCE.Marks)
WHEN NOT MATCHED BY SOURCE THEN  
DELETE; --when we have a name or a note that coincide from the target table with the source table we update them, if they do not coincide we add the values ​​in the source table.

SELECT * FROM SourceTable; -- display the records for verification

SELECT * FROM TargetTable;-- display the records for verification

SELECT StudentID, StudentName FROM  [STUDENTS].[dbo].[InfoStudents]
SELECT TOP 3 * FROM  [STUDENTS].[dbo].[InfoStudents] --display the first three records

Select distinct City FROM  [STUDENTS].[dbo].[InfoStudents] --select the distinct cities from the table

select * FROM  [STUDENTS].[dbo].[InfoStudents] ORDER BY ParentName DESC; --select all the records and sort them by last name in descending order

select * FROM  [STUDENTS].[dbo].[InfoStudents] ORDER BY StudentName, ParentName;--the order will be made according to the first criterion

SELECT COUNT(StudentID), City FROM [STUDENTS].[dbo].[InfoStudents] group by City --will display the number of students in each city

SELECT StudentID, StudentName, COUNT(City) FROM [STUDENTS].[dbo].[InfoStudents] group by GROUPING SETS ((StudentID, StudentName, City), (StudentID), (StudentName), (City));

SELECT COUNT (StudentID),City FROM [STUDENTS].[dbo].[InfoStudents]  GROUP BY City HAVING Count (StudentID) = 1
ORDER BY COUNT(StudentID) DESC; --will only display cities that contain a single student

Select * INTO StudentsBackup FROM [STUDENTS].[dbo].[InfoStudents] 

SELECT StudentID, Count(City) FROM [STUDENTS].[dbo].[InfoStudents] GROUP BY CUBE(StudentID) ORDER BY StudentID; --testing  GROUP BY CUBE

SELECT StudentID, Count(City) FROM [STUDENTS].[dbo].[InfoStudents] GROUP BY ROLLUP(StudentID); -- testing  GROUP BY ROLLUP

CREATE TABLE OffsetMArks (Marks int);

Insert INTO OffsetMArks VALUES('65');
Insert INTO OffsetMArks VALUES('35');
Insert INTO OffsetMArks VALUES('40');
Insert INTO OffsetMArks VALUES('20');
Insert INTO OffsetMArks VALUES('10');

Select * from OffsetMArks order by Marks OFFSET 1 Rows; --show me all the records except the first one

Select * from OffsetMArks order by Marks OFFSET 3 Rows fetch next 1 rows only; --  show me the recording that follows after the 3rd 
--fetch provides the number of records

 CREATE TABLE SupplierTable 
 (
 SupplierID int NOT NULL,
 DaysOfManufacture int,
 Cost int,
 CustomerID int,
 PurchaseID varchar(4000)
 );

 INSERT INTO SupplierTable VALUES ('1','10','100','11','P1');
  INSERT INTO SupplierTable VALUES ('2','20','200','22','P2');
  INSERT INTO SupplierTable VALUES ('3','30','300','11','P3');
  INSERT INTO SupplierTable VALUES ('4','40','400','22','P1');
  INSERT INTO SupplierTable VALUES ('5','50','500','33','P3');
  INSERT INTO SupplierTable VALUES ('6','60','600','33','P1');
  INSERT INTO SupplierTable VALUES ('7','70','700','11','P2');
  INSERT INTO SupplierTable VALUES ('8','80','800','22','P1');
  INSERT INTO SupplierTable VALUES ('9','90','900','11','P1');

  select Customerid,AVG(Cost) as AverageCostOfCustomer From SupplierTable GROUP BY CustomerID; --averages each cost

  SELECT 'AverageCostOfCustomer' AS Cost_According_To_Customers, [11], [22], [33]
  FROM (
  SELECT CustomerID,Cost From SupplierTable) AS SourceTable
  PIVOT
  (
  AVG(Cost) FOR CustomerID IN ([11],[22],[33])) AS PivotTable;

  CREATE TABLE SampleTable (SupplierID int, AAA int , BBB int, CCC int)
  GO 
  INSERT INTO SampleTable VALUES(1,2,7,8);
  INSERT INTO SampleTable VALUES(1,8,1,2);
  INSERT INTO SampleTable VALUES(2,4,6,9);
  GO
  SELECT* FROM SampleTable;

  SELECT SupplierID, Customers, Products
  FROM
  (select SupplierId, AAA, BBB, CCC FROM SampleTable) p
  UNPIVOT
  (Products FOR Customers in (AAA,BBB,CCC)) AS Example;
  GO --Unpivot converts unique values ​​in a single column into multiple output columns and performs aggregations on any values ​​in the remaining column.
  -- shows us how many products each buyer has with the associated supplierID.
  SELECT 40 +60

  selecT * FROM OffsetMArks Where Marks >= '40'; -- select grades greater than 40

  DECLARE @VAR1 INT =30;
  SET @VAR1 %= 16;
  SELECT @VAR1 AS Example; 

  SELECT * FROM  OffsetMArks WHERE Marks BETWEEN '30' AND '60' --displays grades between 30 and 60


   SELECT * FROM  OffsetMArks WHERE Marks > '30' OR Marks < '60' 

   SELECT * FROM  [STUDENTS].[dbo].[InfoStudents] Where StudentName like 'c%' --displays students whose names begin with c

   SELECT * FROM  [STUDENTS].[dbo].[InfoStudents] Where StudentName like 'c%r' --displays students whose names begin with c and end with r

   DECLARE @exid hierarchyid;
   SELECT @exid = hierarchyid::GetRoot();
   PRINT @exid.ToString();

   Select(StudentName + ',' + ParentName) AS Name FROM [STUDENTS].[dbo].[InfoStudents]; 

   select AVG(Marks) from OffsetMArks; 


   CREATE TABLE StudentsDetails
(
StudentID int,
StudentName varchar(8000),
ParentName varchar(8000),
PhoneNumber bigint,
AdressOfStudent varchar(8000),
City varchar (8000),
Contry varchar(8000)
);

INSERT INTO StudentsDetails VALUES ('01', 'Andrei','Stoica', '07612512989','Strada Opanez numarul 45','Craiova','Romania');
INSERT INTO StudentsDetails VALUES ('02', 'Catalin','Popa', '0761231009','Bulevardul Iuliu Maniu, numarul5','Bucuresti','Romania');
INSERT INTO StudentsDetails VALUES ('03', 'Mirela','Vaida', '0734004044','Strada Amaradia,numarul 45','Craiova','Romania');


Select * FROM  [STUDENTS].[dbo].[InfoStudents]
Intersect
select * from StudentsDetails 


Select * FROM  [STUDENTS].[dbo].[InfoStudents]
except
select * from StudentsDetails 

SELECT StudentName, ParentName
FROM [STUDENTS].[dbo].[InfoStudents]
WHERE AdressOfStudent IN (SELECT AdressOfStudent FROM StudentsBackup WHERE Contry ='Romania')


CREATE TABLE Subjects(SubjectID int, StudentID int, SubjectName varchar(8000))

INSERT INTO Subjects VALUES ('10','10','Matematica');
INSERT INTO Subjects VALUES ('2','11','Fizica');
INSERT INTO Subjects VALUES ('3','12','Chimie');


--Join

SELECT Subjects.SubjectID, STUDENTS.dbo.InfoStudents.StudentName
FROM Subjects
INNER JOIN
STUDENTS.dbo.InfoStudents ON
Subjects.StudentID = STUDENTS.dbo.InfoStudents.StudentID 

SELECT Subjects.SubjectID, STUDENTS.dbo.InfoStudents.StudentName
FROM STUDENTS.dbo.InfoStudents
Left JOIN
Subjects ON
STUDENTS.dbo.InfoStudents.StudentID = Subjects.StudentID 
order By STUDENTS.dbo.InfoStudents.StudentName 


SELECT Subjects.SubjectID, Subjects.SubjectName
FROM STUDENTS.dbo.InfoStudents
right JOIN
Subjects ON
STUDENTS.dbo.InfoStudents.StudentID = Subjects.StudentID 
order By Subjects.SubjectName 

SELECT Subjects.SubjectID, STUDENTS.dbo.InfoStudents.StudentName
FROM STUDENTS.dbo.InfoStudents
FULL OUTER JOIN
Subjects ON
STUDENTS.dbo.InfoStudents.StudentID = Subjects.StudentID 
order By STUDENTS.dbo.InfoStudents.StudentName 

--PROCEDURE

 CREATE PROCEDURE Students_City @SCity varchar(8000)
 AS
 Select * from STUDENTS.dbo.InfoStudents
 Where City = @SCity
 GO
 Select * from STUDENTS.dbo.InfoStudents
 Execute Students_City @SCity = 'Romania' 

 --DCL COMANDS
 CREATE LOGIN SAMPLE WITH PASSWORD='peleacezar'
 Create USER CEZAR for login SAMPLE
 Revoke select on Students.dbo.InfoStudents to CEZAR

 --TCL COMANDS --Transactions

 CREATE TABLE TCLSample (StudentID int, StudentName varchar(8000), Marks int);

 INSERT INTO TCLSample VALUES (1,'Cezar', 22);
INSERT INTO TCLSample VALUES (2,'Catalin', 23);
INSERT INTO TCLSample VALUES (3,'Ion', 25);

BEGIN TRY
BEGIN TRANSACTION
INSERT INTO TCLSample VALUES (4,'Mario',40);
Update TCLSample SET StudentName = 'Marian' Where StudentID= '4';
UPDAte TCLSample SET Marks ='67' where StudentID='4';
COMMIT TRANSACTION
PRINT 'Transaction Completed'
end TRY
Begin CAtch
RollBack Transaction
Print 'Transaction Unsuccessful and rolledback'
End Catch

Select * from TCLSample

--exception Handling
throw 5100, 'Record does not exist.',1;

Begin Try
Select PhoneNumber+StudentName From STUDENTS.dbo.InfoStudents;
END TRY
BEGIN CATCH
PRINT 'NOT possible'
end catch
