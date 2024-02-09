SELECT *
,[COURSE LEVEL] + '-' + [SECTION] + ' (' + [TERM] + ')' as 'COMBUTATION!'

	   
FROM [CourseOfferings$] 
WHERE 
[COURE NAME] LIKE 'ACCT%'
AND 
[Credit Hours] BETWEEN 1 AND 2
ORDER By [Course ID]

;

/*
Notes! Wooo! But where is my # >:(
*/