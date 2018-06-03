-- Создается на стороне Receiver.
CREATE BROKER PRIORITY priority_name
FOR CONVERSATION
SET 
( 
    CONTRACT_NAME = contract_name
   ,LOCAL_SERVICE_NAME = local_service_name
   ,REMOTE_SERVICE_NAME = N'remote_service_name' 
   ,PRIORITY_LEVEL = priority_value -- From 1 (lowest priority) to 10 (highest priority). The default is 5.
)