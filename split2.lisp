#! /usr/bin/clisp

(if (not (equal (length *args*) 3))
    (progn
      (format t "Usage split.lisp divisor input base")
      (exit 1)))

(setq divisor (parse-integer (car *args*)))
(setq input   (car (cdr *args*)))
(setq base    (caddr *args*))

(setq c_start  0)
(setq c_end    0)
(setq total    0)
(setq quotient 0)
(setq toomuch  0)
(setq part     0)
(setq fplist  '())

(let ((in (open input :direction :input)))
  (loop for line = (read-line in nil)
	while line do (setq total (+ total 1)))
  (close in))

(setq quotient (floor (/ total divisor)))
(setq toomuch  (floor (mod total divisor)))

;;
(dotimes (no divisor)
  (let ((out (open (format nil "~A~2,'0D" base no) :direction :output)))
    (push out fplist)))
;;    (format t "~A~2,'0D~%" base no)))
(nreverse fplist)

(let
    ((in (open input :direction :input))
     (cnt 0)
     (line ""))
  (loop
   (setq line (read-line in nil))
   (if (null line)
       (quit))
   (setq cnt (+ cnt 1))
   (if (> cnt c_end)
       (progn
	 (if (< part toomuch)
	     (progn
	       (setq c_start (+ c_end 1))
	       (setq c_end   (+ c_start quotient)))
	   (progn
	     (setq c_start (+ c_end 1))
	     (setq c_end   (+ c_start quotient -1))))
	 (setq part (+ part 1))
	 (format t "Part[~D] Start[~8,'0D] End[~8,'0D] Cnt[~8,'0D]~%"
		 part c_start c_end (+ (- c_end c_start) 1))))
   (format (elt fplist (- part 1)) "~A~%" line))
   (close in))
;;
(dotimes (no divisor)
  (close (pop fplist)))





