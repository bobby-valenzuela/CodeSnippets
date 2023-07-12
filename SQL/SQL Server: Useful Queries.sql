-- See if a given column has identiy property
SELECT COLUMNPROPERTY(OBJECT_ID('TableName'),'ColumnName','isidentity')

-- Get table strcuture
SELECT * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='<TABLE_NAME>'

-- Get indexes
EXEC sp_helpindex <TABLE_NAME>

-- Copy Table Strcuture to new table (minus constraints, indexes, etc.)
SELECT top 0 * INTO source_table_copy FROM source_table;

-- Copy data from source table into new (copied) table
INSERT INTO target_table SELECT * FROM source_table;

-- Create Non-Clustered Index
CREATE NONCLUSTERED INDEX [<INDEX_NAME>] ON [dbo].[<TABLE_NAME>]
(
	[COLUMN_NAME],[COLUMN_NAME] ASC ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
