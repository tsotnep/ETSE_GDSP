# somehow it doest not even go in spam, anymore.

set DATE [exec date]

set msg {From: VIVADO_BITSTREAM@tsotnep-pc.com}
append msg \n "To: "  [join tsotnep@gmail.com]
append msg \n "Subject: VIVADO_JOB_START"
append msg \n\n job start date : $DATE

exec /usr/lib/sendmail -oi -t << $msg
