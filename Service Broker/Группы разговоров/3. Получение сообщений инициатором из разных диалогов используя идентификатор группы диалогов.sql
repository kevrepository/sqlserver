-- Получить сообщения, используя идентификатор группы диалогов.
RECEIVE *
FROM    communication.QueueReceivedData
WHERE   conversation_group_id = 'AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE';

GO