DECLARE @getid CURSOR

-- Columns
DECLARE @id INT
DECLARE @name NVARCHAR(MAX)

-- Define cursor
SET @getid = CURSOR FOR
SELECT 
	--[DEFINE]
	id,DisplayName
FROM   
	VeeamOutlook365Teams

-- Open/use cursor
OPEN @getid

	--[DEFINE] Map cursor vars to cols 
	FETCH NEXT	FROM @getid INTO @id, @name

	-- While no errs fetching a row...
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--[MAIN_START]

			PRINT CONCAT(@id,'|',@name)
			
			--[MAIN_END]

			FETCH NEXT FROM @getid INTO @id, @name
		END

CLOSE @getid

-- Reset cursor
DEALLOCATE @getid
