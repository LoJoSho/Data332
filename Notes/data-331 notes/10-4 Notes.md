
- Entity
	- A noun (person, place, thing)
- Attributes
	- Property of a noun
- Relationship
	- Association between entities
- One-to-many relationship
	- One entity related to many other entities
- Repeating groups
	- Multiple entries in an individual location
- Relation
	- Two dimensional table
		- Entries in table are single value
		- All columns is distinct
		- All rows is distinct
		- Order of rows/columns immaterial
- Functional Dependency
	- One column determines another column value
		- B is functionally dependent on A
		- A functionally determines B
- Primary Key
	- A unique identifier for a table
- Normalization
	- "Good Design" - Matt
	- Identifying existing problems in a database design and implementing ways to correct them
	- 3 Steps:
		- First normal form (1NF)
			- A table that does not contain any duplicate values
			- Better than unnormalized table.
		- Second normal form (2NF)
			- Eliminate Transitive property 
		- Third normal form (3NF)
- Entity-Relationship
	- Diagram which rectangles represent entities, line represent relationships
- Original E-R Dyagrams
	- 

-
Invoices(_Invoice Number_, Date, CustID)
- Underline primary key in documentation
->
Invoices(InvoiceNum, Item ID)
-



