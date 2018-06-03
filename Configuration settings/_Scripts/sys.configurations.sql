/*
    value
        Установленное значение параметра.
    value_in_use
        Текущее значение параметра.
    minimum
        Минимальное значение параметра конфигурации.
    maximum
        Максимальное значение параметра конфигурации.
    is_dynamic
        Переменная, вступающая в силу после выполнения инструкции RECONFIGURE.
    is_advanced
        Переменная отображается только тогда, когда show advancedoption имеет значение.
*/

SELECT name
      ,value
      ,value_in_use
      ,minimum
      ,maximum
      ,description
      ,is_dynamic
      ,is_advanced
FROM   sys.configurations
ORDER  BY name;
GO