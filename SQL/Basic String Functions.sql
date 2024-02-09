--STRING Functions

--Concat, CONCAT_WS
Select CONCAT('a','b','c','d')
Select CONCAT_WS(' ','a','b','c','d') -- WS=With Seperator
Select 'a' + 'b' + 'c' + 'd' --also use +

Select CONCAT(LAST_NAME,',',FIRST_NAME) from CUSTOMER 
Select CONCAT_WS(',',LAST_NAME,FIRST_NAME) from CUSTOMER 

--Left, Right, Substring
--Left
Select Left('abcd',2) 
Select Left('abcd',6) --Won't complain if you go over
Select Left(Last_name,3) from Customer

--Right
Select Right('abcd',2) 
Select Right('abcd',6) --Won't complain if you go over
Select Right(Last_name,3) from Customer

--Substring
Select SUBSTRING('abcd',1,2) --Same as left 2
Select SUBSTRING('abcd',2,2) --Take Middle 2 characters
Select SUBSTRING('abcd',3,4) --Effectively take the last two, won't complain if you go over

--LTRIM, RTRIM, TRIM
declare @w char(100) = '                 Some  White   Space                          '
select @w
Select LTRIM(@w)
Select RTRIM(@w)
Select TRIM(@w)

--Can use Replace as well
Select Replace(@w,' ','')

--REPLACE
declare @w2 char(100) = '////////Some*****BAD---CHARACTER$)))))'
Select @w2
Select REPLACE(@w2,'/','')
Select Replace(@w2,')','')
Select Replace(REPLACE(@w2,'/',''),')','') --You can start to nest these, but it gets ugly fast.  

--Sequentially update a value is a little easier to read
Set @w2 = REPLACE(@w2,'/','')
Set @w2 = Replace(@w2,')','')
Select @w2

--UPPER and LOWER
Select upper('a')
Select lower('A')

Select CONCAT_WS(',',LAST_NAME,FIRST_NAME) from CUSTOMER 
Select UPPER(CONCAT_WS(',',LAST_NAME,FIRST_NAME)) from CUSTOMER 
Select LOWER(CONCAT_WS(',',LAST_NAME,FIRST_NAME)) from CUSTOMER 
