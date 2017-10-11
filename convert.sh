#!/bin/bash

find _posts/ dodatkowe-materialy-do-nauki/ kurs-programowania-java/ o-mnie/ -exec sed -i "s/&oacute;/ó/g" {} \;
find _posts/ dodatkowe-materialy-do-nauki/ kurs-programowania-java/ o-mnie/ -exec sed -i "s/&#47;/\//g" {} \;
