#!/bin/sh
# decrot.sh
# decrypt rot13

ROTNUM=13

declare -a KEYSTR=()
declare -a STRENC=()
declare -a STRDEC=()

var1="$(echo {a..z} | cut -d' ' -f${ROTNUM}-$(expr ${ROTNUM} + 1))"
var2=" $(echo {A..Z} | cut -d' ' -f${ROTNUM}-$(expr ${ROTNUM} + 1))"
declare -a KEYSTR=(${var1}${var2})

var3=$(echo "{${KEYSTR[1]}..z} {a..${KEYSTR[0]}} {N..Z} {A..M}")

declare -a STRENC=($(eval "echo ${var3}"))
declare -a STRDEC=($(echo {a..z} {A..Z}))

STRLEN=$(expr ${#STRENC[@]} - 1)

cat ksnctf_q2.txt | fold -1 | while read q
  do
  for i in $(eval "echo {0..${STRLEN}}")
    do
      if [ "${q}" = "${STRENC[${i}]}" ]; then
        r=${i}
        break
      else
        r=-1
      fi
    done
    if [ ${r} -ge 0 ]; then
      echo -n "${STRDEC[${r}]}"
    else
      if [ "${q}" = "" ]; then
        echo -n " "
      else
        echo -n "${q}"
      fi
    fi
  done
echo

exit

