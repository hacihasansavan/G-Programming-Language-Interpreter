; son gün Yetişmedi hocam ;(

(defvar KeyWord (list "and" "or" "not" "equal" "less" "nil" "list" "append" "concat" "set" "deffun" "for" "if" "exit" "load" "disp" "true" "false"))
(defvar KW (list "KW_AND" "KW_OR" "KW_NOT" "KW_EQUAL" "KW_LESS" "KW_NIL" "KW_LIST" "KW_APPEND" "KW_CONCAT" "KW_SET" "KW_DEFFUN" "KW_FOR" "KW_IF" "KW_EXIT" "KW_LOAD" "KW_DISP" "KW_TRUE" "KW_FALSE"))
(defvar Operator (list "+" "-" "/" "**" "*" "(" ")" "\"" "\"" ","))
(defvar OP (list "OP_PLUS" "OP_MINUS" "OP_DIV" "OP_DBLMULT" "OP_MULT" "OP_OP" "OP_CP" "OP_OC" "OP_CC" "OP_COMMA"))

(defvar Space (list "\n" "\t" " "))
(defvar Comment ";")
(defvar Possible (list "(" ")" "\""))
(defvar opoc 0)

(defvar allTokens (list))


;konsoldan string alır. exit gördüğünde sonlandırır 

(defun readList()
    (setq index 0)
    (loop
       	(setq line (read-line))

        (if(string-equal line "exit") (return))
        (if(string-equal line "(exit)") (return))
        (push line lst) 
    )
    ;(reverse lst)
)


; verilen listeyi ekrana yazdırır
(defun printList(listP)
    (setq size (length listP))
    ;(reverse listP)
    (setq index 0)
    (loop
        (write (nth index listP))
        (terpri)
        (setq index (+ index 1))
        (if(equal index size) (return))
    )
)
(defun isItBracket (chr)
	(let ((c (char-int (coerce chr 'character))))
		(or (= c 40) (= c 41))))

(defun isItQuoMark (chr)
	(eq (char-code (coerce chr 'character)) 34))

(defun isItSemicolon (chr)
	(eq (char-code (coerce chr 'character)) 59))


(defun isItZero (chr)
	(eq (char-code (coerce chr 'character)) 48))

(defun isItNumber (chr)
	(let ((c (char-int (coerce chr 'character))))
		(and (>= c (char-int #\0)) (<= c (char-int #\9)))))
	
(defun isItLetter (chr)
	(let ((c (char-int (coerce chr 'character))))
		(and (>= c (char-int #\A)) (<= c (char-int #\z)))))

(defun isItSpace (c) (char= c #\Space))

; bu fonksiyon ana list içinde dolanır ve parse eder. yeni bir list oluşturur
(defun bismillah ()
    (setq size (length listP))
    (setq index 0)
    (loop
        (if ())
        (setq index (+ index 1))
        (if(equal index size) (return))
        (push (nth index listP) tokenizedList)
    )    
)
(defun tokenize (token lst)
	 (let ((c (string (char token 0)))) 
	 (cond ((is-alphap c) (tokenize-identifier token lst))  
	 	   ((is-numericp c) (tokenize-value token))			
	 	   ((is-quomarkp c) (tokenize-string token))
	 	   (t (if (tokenize-op token lst) 					
	 	   (tokenize-op token lst) (errout token c))))))	
	 	   									 
(setq lst (list ))

(defvar tokenizedList(list ))
