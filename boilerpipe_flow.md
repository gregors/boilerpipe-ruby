```
raw html
   |
   |
  sax input -> sax parser(html parser) ->  HTML Content handler -> tokenizer ---------
                                                                                     |
    -------------------------------------<------------------------------------<------|
    |              |            |
text blocks    text blocks  text blocks
    |              |            |
    |              |            |
    -----------------------------
          |
          |
     text document
          |
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
        filter
          |
          |
     text document
          |
  outputs extracted text
  ```
