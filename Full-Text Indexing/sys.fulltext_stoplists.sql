SELECT ftsl.stoplist_id
      ,ftsl.name
      ,ftsw.stopword
      ,ftsw.language
FROM   sys.fulltext_stoplists AS ftsl
       INNER JOIN sys.fulltext_stopwords AS ftsw
               ON ftsl.stoplist_id = ftsw.stoplist_id;