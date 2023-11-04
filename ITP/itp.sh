#!/bin/bash

# define the function to perform calculations
calc() { awk "BEGIN { print $*}"; }

#define sign function
sign() {
  awk "BEGIN { 
    if ($1 > 0) 
      print 1; 
    else if ($1 < 0) 
      print -1; 
    else 
      print 0 
    }"
}



#define absolute value function
abs() {
  awk -v num="$1" "BEGIN { 
    if (num < 0) 
      num = -1*num; 
    print num 
    }"
}

##define ceiling function
#ceil() {
#$(awk "BEGIN { printf \"%.0f\", int($x + ($x > int($x))) }"
#}

ceil() {
    awk -v num="$1" 'BEGIN { ceiling = int(num + (num > int(num))); print ceiling }'
}


x_min=$1
x_max=$2
y=$3
ITP(){
...
echo x_best
}
