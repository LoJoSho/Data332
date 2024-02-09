
/*To Execute

EXECUTE @RC = [dbo].[InsertCustomer] 
   @CustID = '999'
   ,@Email = 'mattpelham2@augustana.edu'

Print @RC
*/

/*
Create Procedure myprocname
As 
Begin
	
end
*/

Create Procedure InsertCustomer( --Parameter List
@CustID char(3)
,@FirstName varchar(20) = 'N/A' --Default Values
,@LastName varchar(20) = 'N/A'
,@Address1 varchar(20) = NULL
,@City varchar(15) = NULL
,@State char(2) = NULL
,@Postal char(5) = NULL
,@Email varchar(30) = NULL
)
As
Begin

--Declare Variables for use in the stored procedure scope
Declare @Balance decimal(7,2) = 0 --Assign a default value
		,@CreditLimit decimal(7,2)
		,@RepID char(2)

Set @RepID = '05' --Assign values manually

Select @CreditLimit = min(Credit_Limit) from dbo.CUSTOMER --Assign Value using a select statement

--If Then Else Statements - If an E-mail address is supplied, check to make sure it isn't already in use
--If Then Else Statements commonly used to check for more complex constraints
If ((@Email IS NOT NULL) AND NOT EXISTS (Select EMAIL from dbo.CUSTOMER where EMAIL=@email)) --EXISTS is a boolean operator will return True/False.
	Begin
		INSERT INTO [dbo].[CUSTOMER]
			   ([CUST_ID]
			   ,[FIRST_NAME]
			   ,[LAST_NAME]
			   ,[ADDRESS]
			   ,[CITY]
			   ,[STATE]
			   ,[POSTAL]
			   ,[EMAIL]
			   ,[BALANCE]
			   ,[CREDIT_LIMIT]
			   ,[REP_ID]
			   )
		 VALUES(
				 @CustID
				,@FirstName
				,@LastName
				,@Address1
				,@City
				,@State
				,@Postal
				,@Email
				,@Balance
				,@CreditLimit
				,@RepID
			)
	End
Else 
	Begin
		return 99 --Return statement to exit stored procedure.  Often, specific integer values are used for error codes
	End

End


