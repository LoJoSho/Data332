-- #1

Create Procedure LSCHULZ_AllNames as 
BEGIN
	SELECT CONCAT_WS(' ', CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME) AS CustomerName, INVOICES.CUST_ID, COUNT(INVOICES.INVOICE_NUM) as InvoiceAmount 
	FROM INVOICES, CUSTOMER WHERE INVOICES.CUST_ID = CUSTOMER.CUST_ID 
	GROUP BY INVOICES.CUST_ID, CONCAT_WS(' ', CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME)
END

-- #2
GO
CREATE PROCEDURE LSCHULZ_InvoiceDetails(
@CUST_ID char(3)
)
AS 
BEGIN
	SELECT YEAR(INVOICES.INVOICE_DATE) as [YEAR], MONTH(INVOICES.INVOICE_DATE) as [MONTH], INVOICES.INVOICE_NUM, ITEM.ITEM_ID, UPPER(ITEM.DESCRIPTION) as [DESCRIPTION],INVOICE_LINE.QUANTITY, INVOICE_LINE.QUOTED_PRICE 
	FROM CUSTOMER, INVOICES, ITEM, INVOICE_LINE
	WHERE CUSTOMER.CUST_ID = @CUST_ID AND INVOICE_LINE.INVOICE_NUM = INVOICES.INVOICE_NUM AND INVOICE_LINE.ITEM_ID = ITEM.ITEM_ID
END

-- #3
GO
CREATE PROCEDURE LSCHULZ_RemoveCustomer(
@CUST_ID char(3)
)
AS
BEGIN	
	DELETE FROM CUSTOMER WHERE CUSTOMER.CUST_ID = @CUST_ID
END

-- #4
GO

CREATE PROCEDURE LSCHULZ_InsertInvoice(
@INVOICE_NUM char(5),
@INVOICE_DATE DATE = NULL,
@CUST_ID char(3) = NULL
)
as
BEGIN
	-- I have no idea how to get todays date <:)
	if (@INVOICE_DATE > TODATETIMEOFFSET('Central Standard Time', 0))
		return -1
	-- check if invoice num already exists. If it does, return failure (-1)
	IF (EXISTS(SELECT INVOICES.INVOICE_NUM FROM INVOICES WHERE INVOICES.INVOICE_NUM = @INVOICE_NUM))
		return -1

	INSERT INTO INVOICES VALUES (@INVOICE_NUM, @INVOICE_DATE, @CUST_ID)
END
-- #5
GO

CREATE PROCEDURE LSCHULZ_NewCustomer(
@CUST_ID char(3),
@FIRST_NAME varchar(20),
@LAST_NAME varchar(20),
@EMAIL varchar(30),
@REP_ID char(2),
@ADDRESS varchar(20) = null,
@CITY varchar(15) = null,
@STATE char(2) = null,
@POSTAL char(5) = null,
@BALANCCE decimal(7,2) = null,
@CREDIT_LIMIT decimal(7,2) = null
)
as
BEGIN
	-- check if email exists, if it does, customer already exists; return failure
	if (EXISTS(SELECT EMAIL FROM CUSTOMER WHERE @EMAIL = CUSTOMER.EMAIL))
		return -1
	-- check and ensure rep id is real
	if (NOT EXISTS(SELECT @REP_ID FROM SALES_REP))
		return -1

	INSERT INTO CUSTOMER(CUST_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, STATE, POSTAL, EMAIL, BALANCE, CREDIT_LIMIT, REP_ID) VALUES (@CUST_ID, @FIRST_NAME, @LAST_NAME, @ADDRESS, @CITY, @STATE, @POSTAL, @EMAIL, @BALANCCE, @CREDIT_LIMIT, @REP_ID)
END

-- #6
GO

CREATE PROCEDURE LSCHULZ_UpdateCustomer(
@CUST_ID char(3),
@FIRST_NAME varchar(20),
@LAST_NAME varchar(20),
@EMAIL varchar(30),
@REP_ID char(2),
@ADDRESS varchar(20) = null,
@CITY varchar(15) = null,
@STATE char(2) = null,
@POSTAL char(5) = null,
@BALANCCE decimal(7,2) = null,
@CREDIT_LIMIT decimal(7,2) = null
)
as
BEGIN
	-- if the customer email does not exist, customer does not exist, ie, no customer to update
	if (NOT EXISTS(SELECT EMAIL FROM CUSTOMER WHERE @EMAIL = CUSTOMER.EMAIL))
		return -1
	-- if sales rep is not real, don't update, return -1 for failure
	if (NOT EXISTS(SELECT @REP_ID FROM SALES_REP))
		return -1

	UPDATE CUSTOMER 
	SET CUST_ID = @CUST_ID, FIRST_NAME = @FIRST_NAME, LAST_NAME = @LAST_NAME, EMAIL = @EMAIL, ADDRESS = @ADDRESS, CITY = @CITY, State = @STATE, Postal = @POSTAL, BALANCE = @BALANCCE, CREDIT_LIMIT = @CREDIT_LIMIT, REP_ID = @REP_ID
	WHERE CUSTOMER.CUST_ID = @CUST_ID
END


-- #7
GO

CREATE PROCEDURE LSCHULZ_UpdateCredit(
@CUST_ID char(3),
@CREDIT_LIMIT decimal(7, 2)
)
as
BEGIN
	-- if less than 0 or greater than 10000, return a -1 (failure)
	IF (@CREDIT_LIMIT < 0 OR @CREDIT_LIMIT > 10000)
		return -1

	UPDATE CUSTOMER
	SET CREDIT_LIMIT = @CREDIT_LIMIT
	WHERE CUSTOMER.CUST_ID = @CUST_ID
END

-- #8
GO

CREATE PROCEDURE LSCHULZ_NewItem(
@ITEM_ID char(4),
@DESCRIPTION varchar(30),
@ON_HAND numeric(18, 0),
@CATEGORY char(3),
@LOCATION char(1) = 'A',
@PRICE decimal(7,2)
)
as
BEGIN
	-- Check if it's in a special warehouse, then check values
	if (@LOCATION IN ('A', 'B', 'C'))
		BEGIN
			IF (@LOCATION = 'A' AND (@ON_HAND <= 1 AND @ON_HAND >= 25))
				return -1
			else IF (@LOCATION = 'B' AND (@ON_HAND <= 1 AND @ON_HAND >= 10))
				return -1
			else IF (@LOCATION = 'C' AND (@ON_HAND <= 1 AND @ON_HAND >= 50))
				return -1
		END
	-- if not the cool 3, do a generic check. If below 1 or above 20, return -1
	else IF (@ON_HAND <= 1 AND @ON_HAND >= 20)
		return -1

	-- wooo! it passed and is being sent to be inserted!
	INSERT INTO ITEM(ITEM_ID, DESCRIPTION, ON_HAND, CATEGORY, LOCATION, PRICE) VALUES(@ITEM_ID, @DESCRIPTION, @ON_HAND, @CATEGORY, @LOCATION, @PRICE)
END
