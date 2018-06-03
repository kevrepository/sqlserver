/*
    https://docs.microsoft.com/en-us/sql/t-sql/statements/create-security-policy-transact-sql

    CREATE SECURITY POLICY [schema_name. ] security_policy_name
        { ADD [ FILTER | BLOCK ] } PREDICATE tvf_schema_name.security_predicate_function_name   
          ( { column_name | arguments } [ , …n] ) ON table_schema_name. table_name    
          [ <block_dml_operation> ] , [ , …n] 
        [ WITH ( STATE = { ON | OFF }  [,] [ SCHEMABINDING = { ON | OFF } ] ) ]  
        [ NOT FOR REPLICATION ] 
    [;]  

    <block_dml_operation>  
        [ { AFTER { INSERT | UPDATE } }   
        | { BEFORE { UPDATE | DELETE } } ]  
*/

USE AdventureWorks2014;
GO

CREATE SCHEMA security;
GO  

-- Создание предиката безопасности.
CREATE OR ALTER FUNCTION security.security_predicate_name(@BusinessEntityID int)
RETURNS TABLE
    WITH SCHEMABINDING
AS  
RETURN
(
    SELECT 1 AS security_predicate_result
    FROM   HumanResources.Employee
    WHERE  LoginID = 'adventure-works\' + SUSER_SNAME()
           AND BusinessEntityID = @BusinessEntityID
);
GO

-- Создание политики безопасности.
CREATE SECURITY POLICY security.security_policy_name
    ADD FILTER PREDICATE security.security_predicate_name(BusinessEntityID) ON HumanResources.Employee
    WITH (STATE = ON, SCHEMABINDING = ON);

-- DROP SECURITY POLICY security.security_policy_name;
GO