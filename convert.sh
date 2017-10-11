#!/bin/bash

for stuff_to_do in "s/&oacute;/ó/g" "s/&#47;/\//g" "/^author:$/d" "/^  display_name: Marcin Pietraszek$/d" "/^  login: marcin$/d" "/^  email: m.pietraszek@gmail.com$/d" "/^  url: ''$/d" "/^author_login: marcin$/d" "/^author_email: m.pietraszek@gmail.com$/d"
do
    echo Doing stuff "${stuff_to_do}"
    find _posts/ dodatkowe-materialy-do-nauki/ kurs-programowania-java/ o-mnie/ -exec sed -i "${stuff_to_do}" {} \;
    echo
done
