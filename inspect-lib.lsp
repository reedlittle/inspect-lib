
		;;; get the list of symbol/type pairs
(setf in (open "lib.4" :direction :input))
(setf g (read in))
(close in)

		;;; prime the search with the second pair from the input file
(setf second (cadr g))

		;;; these are the output files into which we "sort" symbols
(setf yes (open "used" :direction :output))
(setf no  (open "not-used"  :direction :output))

		;;; now loop through all pairs from the input file
(loop while g do
      (if (equal (cadar g) (cadr second))
		;;;  the current symbol and next symbol from the input file are the same
		;;;  so send symbol to the used file
		;;;
		;;;  if we get here this is a symbol with two pairs (T/t and U)
         (progn (prin1 (cadr second) yes)
                (terpri yes))
         (if (equal (caar g) T)
		;;;  the current symbol type is a T or t (due to force up case by reader
		;;;  both will be T)
		;;;  send it to the not-used file
		;;;
		;;;  if we get here this is the only pair from the input file with this
		;;;  symbol name and T or t type
            (progn (prin1 (cadar g) no)
                (terpri no))
		;;; otherwise this is not a symbol of interest, print nothing
         )
      )
		;;;  on to the next pair from the input file
      (setf g (cdr g))
      (setf second (cadr g))
)

(close yes)
(close no)

