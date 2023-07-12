# Perl One-Liners

Source: https://nostarch.com/perloneliners  
Modified from: https://catonmat.net/ftp/perl1line.txt

<br />

# Table of Contents
1. [File Spacing](#file-spacing)
2. [Line Numbering](#line-numbering)
3. [Calculations](#calculations)
4. [String and Array Creattion](#string-creation-and-array-creation)
5. [Text Conversion and Substitution](#text-conversion-and-substitution)
6. [Selective Printing and Deleting of certain Lines](#selective-printing-and-deleting-of-certain-lines)
7. [Handy Regular Expressions](#handy-regular-expressions)

<br />

# FILE SPACING

#### Double space a file
```bash
perl -pe '$\="\n"'
```

<br />


```bash
perl -pe 'BEGIN { $\="\n" }'
```

<br />


```bash
perl -pe '$_ .= "\n"'
```

<br />


```bash
perl -pe 's/$/\n/'
```

<br />


```bash
perl -nE 'say'
```

<br />



#### Double space a file, except the blank lines
```bash
perl -pe '$_ .= "\n" unless /^$/'
```

<br />


```bash
perl -pe '$_ .= "\n" if /\S/'
```

<br />



#### Triple space a file
```bash
perl -pe '$\="\n\n"'
```

<br />


```bash
perl -pe '$_.="\n\n"'
```

<br />



#### N-space a file
```bash
perl -pe '$_.="\n"x7'
```

<br />



#### Add a blank line before every line
```bash
perl -pe 's//\n/'
```

<br />



#### Remove all blank lines
```bash
perl -ne 'print unless /^$/'
```

<br />


```bash
perl -lne 'print if length'
```

<br />


```bash
perl -ne 'print if /\S/'
```

<br />



#### Remove all consecutive blank lines, leaving just one
```bash
perl -00 -pe ''
```

<br />


```bash
perl -00pe0
```

<br />



#### Compress/expand all blank lines into N consecutive ones
```bash
perl -00 -pe '$_.="\n"x4'
```

<br />



#### Fold a file so that every set of 10 lines becomes one tab-separated line
```bash
perl -lpe '$\ = $. % 10 ? "\t" : "\n"'
```

<br />




# LINE NUMBERING

#### Number all lines in a file
```bash
perl -pe '$_ = "$. $_"'
```

<br />



#### Number only non-empty lines in a file
```bash
perl -pe '$_ = ++$a." $_" if /./'
```

<br />



#### Number and print only non-empty lines in a file (drop empty lines)
```bash
perl -ne 'print ++$a." $_" if /./'
```

<br />



#### Number all lines but print line numbers only non-empty lines
```bash
perl -pe '$_ = "$. $_" if /./'
```

<br />



#### Number only lines that match a pattern, print others unmodified
```bash
perl -pe '$_ = ++$a." $_" if /regex/'
```

<br />



#### Number and print only lines that match a pattern
```bash
perl -ne 'print ++$a." $_" if /regex/'
```

<br />



#### Number all lines, but print line numbers only for lines that match a pattern
```bash
perl -pe '$_ = "$. $_" if /regex/'
```

<br />



#### Number all lines in a file using a custom format (emulate cat -n)
```bash
perl -ne 'printf "%-5d %s", $., $_'
```

<br />



#### Print the total number of lines in a file (emulate wc -l)
```bash
perl -lne 'END { print $. }'
```

<br />


```bash
perl -le 'print $n=()=<>'
```

<br />


```bash
perl -le 'print scalar(()=<>)'
```

<br />


```bash
perl -le 'print scalar(@foo=<>)'
```

<br />


```bash
perl -ne '}{print $.'
```

<br />


```bash
perl -nE '}{say $.'
```

<br />



#### Print the number of non-empty lines in a file
```bash
perl -le 'print scalar(grep{/./}<>)'
```

<br />


```bash
perl -le 'print ~~grep{/./}<>'
```

<br />


```bash
perl -le 'print~~grep/./,<>'
```

<br />


```bash
perl -E 'say~~grep/./,<>'
```

<br />



#### Print the number of empty lines in a file
```bash
perl -lne '$a++ if /^$/; END {print $a+0}'
```

<br />


```bash
perl -le 'print scalar(grep{/^$/}<>)'
```

<br />


```bash
perl -le 'print ~~grep{/^$/}<>'
```

<br />


```bash
perl -E 'say~~grep{/^$/}<>'
```

<br />



#### Print the number of lines in a file that match a pattern (emulate grep -c)
```bash
perl -lne '$a++ if /regex/; END {print $a+0}'
```

<br />


```bash
perl -nE '$a++ if /regex/; END {say $a+0}'
```

<br />




# CALCULATIONS


#### Check if a number is a prime
```bash
perl -lne '(1x$_) !~ /^1?$|^(11+?)\1+$/ && print "$_ is prime"'
```

<br />



#### Print the sum of all the fields on a line
```bash
perl -MList::Util=sum -alne 'print sum @F'
```

<br />



#### Print the sum of all the fields on all lines
```bash
perl -MList::Util=sum -alne 'push @S,@F; END { print sum @S }'
```

<br />


```bash
perl -MList::Util=sum -alne '$s += sum @F; END { print $s }'
```

<br />



#### Shuffle all fields on a line
```bash
perl -MList::Util=shuffle -alne 'print "@{[shuffle @F]}"'
```

<br />


```bash
perl -MList::Util=shuffle -alne 'print join " ", shuffle @F'
```

<br />



#### Find the minimum element on a line
```bash
perl -MList::Util=min -alne 'print min @F'
```

<br />



#### Find the minimum element over all the lines
```bash
perl -MList::Util=min -alne '@M = (@M, @F); END { print min @M }'
```

<br />


```bash
perl -MList::Util=min -alne '$min = min @F; $rmin = $min unless defined $rmin && $min > $rmin; END { print $rmin }'
```

<br />



#### Find the maximum element on a line
```bash
perl -MList::Util=max -alne 'print max @F'
```

<br />



#### Find the maximum element over all the lines
```bash
perl -MList::Util=max -alne '@M = (@M, @F); END { print max @M }'
```

<br />



#### Replace each field with its absolute value
```bash
perl -alne 'print "@{[map { abs } @F]}"'
```

<br />



#### Find the total number of fields (words) on each line
```bash
perl -alne 'print scalar @F'
```

<br />



#### Print the total number of fields (words) on each line followed by the line
```bash
perl -alne 'print scalar @F, " $_"'
```

<br />



#### Find the total number of fields (words) on all lines
```bash
perl -alne '$t += @F; END { print $t}'
```

<br />



#### Print the total number of fields that match a pattern
```bash
perl -alne 'map { /regex/ && $t++ } @F; END { print $t }'
```

<br />


```bash
perl -alne '$t += /regex/ for @F; END { print $t }'
```

<br />


```bash
perl -alne '$t += grep /regex/, @F; END { print $t }'
```

<br />



#### Print the total number of lines that match a pattern
```bash
perl -lne '/regex/ && $t++; END { print $t }'
```

<br />



#### Print the number PI to n decimal places
```bash
perl -Mbignum=bpi -le 'print bpi(n)'
```

<br />



#### Print the number PI to 39 decimal places
```bash
perl -Mbignum=PI -le 'print PI'
```

<br />



#### Print the number E to n decimal places
```bash
perl -Mbignum=bexp -le 'print bexp(1,n+1)'
```

<br />



#### Print the number E to 39 decimal places
```bash
perl -Mbignum=e -le 'print e'
```

<br />



#### Print UNIX time (seconds since Jan 1, 1970, 00:00:00 UTC)
```bash
perl -le 'print time'
```

<br />



#### Print GMT (Greenwich Mean Time) and local computer time
```bash
perl -le 'print scalar gmtime'
```

<br />


```bash
perl -le 'print scalar localtime'
```

<br />



#### Print local computer time in H:M:S format
```bash
perl -le 'print join ":", (localtime)[2,1,0]'
```

<br />



#### Print yesterday's date
```bash
perl -MPOSIX -le '@now = localtime; $now[3] -= 1; print scalar localtime mktime @now'
```

<br />



#### Print date 14 months, 9 days and 7 seconds ago
```bash
perl -MPOSIX -le '@now = localtime; $now[0] -= 7; $now[4] -= 14; $now[7] -= 9; print scalar localtime mktime @now'
```

<br />



#### Prepend timestamps to stdout (GMT, localtime)
tail -f logfile | perl -ne 'print scalar gmtime," ",$_'
tail -f logfile | perl -ne 'print scalar localtime," ",$_'

#### Calculate factorial of 5
```bash
perl -MMath::BigInt -le 'print Math::BigInt->new(5)->bfac()'
```

<br />


```bash
perl -le '$f = 1; $f *= $_ for 1..5; print $f'
```

<br />



#### Calculate greatest common divisor (GCM)
```bash
perl -MMath::BigInt=bgcd -le 'print bgcd(@list_of_numbers)'
```

<br />



#### Calculate GCM of numbers 20 and 35 using Euclid's algorithm
```bash
perl -le '$n = 20; $m = 35; ($m,$n) = ($n,$m%$n) while $n; print $m'
```

<br />



#### Calculate least common multiple (LCM) of numbers 35, 20 and 8
```bash
perl -MMath::BigInt=blcm -le 'print blcm(35,20,8)'
```

<br />



#### Calculate LCM of 20 and 35 using Euclid's formula: n*m/gcd(n,m)
```bash
perl -le '$a = $n = 20; $b = $m = 35; ($m,$n) = ($n,$m%$n) while $n; print $a*$b/$m'
```

<br />



#### Generate 10 random numbers between 5 and 15 (excluding 15)
```bash
perl -le '$n=10; $min=5; $max=15; $, = " "; print map { int(rand($max-$min))+$min } 1..$n'
```

<br />



#### Find and print all permutations of a list
```bash
perl -MAlgorithm::Permute -le '$l = [1,2,3,4,5]; $p = Algorithm::Permute->new($l); print @r while @r = $p->next'
```

<br />



#### Generate the power set
```bash
perl -MList::PowerSet=powerset -le '@l = (1,2,3,4,5); for (@{powerset(@l)}) { print "@$_" }'
```

<br />



#### Convert an IP address to unsigned integer
```bash
perl -le '$i=3; $u += ($_<<8*$i--) for "127.0.0.1" =~ /(\d+)/g; print $u'
```

<br />


```bash
perl -le '$ip="127.0.0.1"; $ip =~ s/(\d+)\.?/sprintf("%02x", $1)/ge; print hex($ip)'
```

<br />


```bash
perl -le 'print unpack("N", 127.0.0.1)'
```

<br />


```bash
perl -MSocket -le 'print unpack("N", inet_aton("127.0.0.1"))'
```

<br />



#### Convert an unsigned integer to an IP address
```bash
perl -MSocket -le 'print inet_ntoa(pack("N", 2130706433))'
```

<br />


```bash
perl -le '$ip = 2130706433; print join ".", map { (($ip>>8*($_))&0xFF) } reverse 0..3'
```

<br />


```bash
perl -le '$ip = 2130706433; $, = "."; print map { (($ip>>8*($_))&0xFF) } reverse 0..3'
```

<br />




# STRING CREATION AND ARRAY CREATION


#### Generate and print the alphabet
```bash
perl -le 'print a..z'
```

<br />


```bash
perl -le 'print ("a".."z")'
```

<br />


```bash
perl -le '$, = ","; print ("a".."z")'
```

<br />


```bash
perl -le 'print join ",", ("a".."z")'
```

<br />



#### Generate and print all the strings from "a" to "zz"
```bash
perl -le 'print ("a".."zz")'
```

<br />


```bash
perl -le 'print "aa".."zz"'
```

<br />



#### Create a hex lookup table
@hex = (0..9, "a".."f")

#### Convert a decimal number to hex using @hex lookup table
```bash
perl -le '$num = 255; @hex = (0..9, "a".."f"); while ($num) { $s = $hex[($num%16)&15].$s; $num = int $num/16 } print $s'
```

<br />


```bash
perl -le '$hex = sprintf("%x", 255); print $hex'
```

<br />


```bash
perl -le '$num = "ff"; print hex $num'
```

<br />



#### Generate a random 8 character password
```bash
perl -le 'print map { ("a".."z")[rand 26] } 1..8'
```

<br />


```bash
perl -le 'print map { ("a".."z", 0..9)[rand 36] } 1..8'
```

<br />



#### Create a string of specific length
```bash
perl -le 'print "a"x50'
```

<br />



#### Create a repeated list of elements
```bash
perl -le '@list = (1,2)x20; print "@list"'
```

<br />



#### Create an array from a string
@months = split ' ', "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
@months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/

#### Create a string from an array
@stuff = ("hello", 0..9, "world"); $string = join '-', @stuff

#### Find the numeric values for characters in the string
```bash
perl -le 'print join ", ", map { ord } split //, "hello world"'
```

<br />



#### Convert a list of numeric ASCII values into a string
```bash
perl -le '@ascii = (99, 111, 100, 105, 110, 103); print pack("C*", @ascii)'
```

<br />


```bash
perl -le '@ascii = (99, 111, 100, 105, 110, 103); print map { chr } @ascii'
```

<br />



#### Generate an array with odd numbers from 1 to 100
```bash
perl -le '@odd = grep {$_ % 2 == 1} 1..100; print "@odd"'
```

<br />


```bash
perl -le '@odd = grep { $_ & 1 } 1..100; print "@odd"'
```

<br />



#### Generate an array with even numbers from 1 to 100
```bash
perl -le '@even = grep {$_ % 2 == 0} 1..100; print "@even"'
```

<br />



#### Find the length of the string
```bash
perl -le 'print length "one-liners are great"'
```

<br />



#### Find the number of elements in an array
```bash
perl -le '@array = ("a".."z"); print scalar @array'
```

<br />


```bash
perl -le '@array = ("a".."z"); print $#array + 1'
```

<br />




# TEXT CONVERSION AND SUBSTITUTION


#### ROT13 a string
'y/A-Za-z/N-ZA-Mn-za-m/'

#### ROT 13 a file
```bash
perl -lpe 'y/A-Za-z/N-ZA-Mn-za-m/' file
```

<br />



#### Base64 encode a string
```bash
perl -MMIME::Base64 -e 'print encode_base64("string")'
```

<br />


```bash
perl -MMIME::Base64 -0777 -ne 'print encode_base64($_)' file
```

<br />



#### Base64 decode a string
```bash
perl -MMIME::Base64 -le 'print decode_base64("base64string")'
```

<br />


```bash
perl -MMIME::Base64 -ne 'print decode_base64($_)' file
```

<br />



#### URL-escape a string
```bash
perl -MURI::Escape -le 'print uri_escape($string)'
```

<br />



#### URL-unescape a string
```bash
perl -MURI::Escape -le 'print uri_unescape($string)'
```

<br />



#### HTML-encode a string
```bash
perl -MHTML::Entities -le 'print encode_entities($string)'
```

<br />



#### HTML-decode a string
```bash
perl -MHTML::Entities -le 'print decode_entities($string)'
```

<br />



#### Convert all text to uppercase
```bash
perl -nle 'print uc'
```

<br />


```bash
perl -ple '$_=uc'
```

<br />


```bash
perl -nle 'print "\U$_"'
```

<br />



#### Convert all text to lowercase
```bash
perl -nle 'print lc'
```

<br />


```bash
perl -ple '$_=lc'
```

<br />


```bash
perl -nle 'print "\L$_"'
```

<br />



#### Uppercase only the first word of each line
```bash
perl -nle 'print ucfirst lc'
```

<br />


```bash
perl -nle 'print "\u\L$_"'
```

<br />



#### Invert the letter case
```bash
perl -ple 'y/A-Za-z/a-zA-Z/'
```

<br />



#### Camel case each line
```bash
perl -ple 's/(\w+)/\u$1/g'
```

<br />


```bash
perl -ple 's/(?<![\'])(\w+)/\u\1/g'
```

<br />



#### Strip leading whitespace (spaces, tabs) from the beginning of each line
```bash
perl -ple 's/^[ \t]+//'
```

<br />


```bash
perl -ple 's/^\s+//'
```

<br />



#### Strip trailing whitespace (space, tabs) from the end of each line
```bash
perl -ple 's/[ \t]+$//'
```

<br />



#### Strip whitespace from the beginning and end of each line
```bash
perl -ple 's/^[ \t]+|[ \t]+$//g'
```

<br />



#### Convert UNIX newlines to DOS/Windows newlines
```bash
perl -pe 's|\n|\r\n|'
```

<br />



#### Convert DOS/Windows newlines to UNIX newlines
```bash
perl -pe 's|\r\n|\n|'
```

<br />



#### Convert UNIX newlines to Mac newlines
```bash
perl -pe 's|\n|\r|'
```

<br />



#### Substitute (find and replace) "foo" with "bar" on each line
```bash
perl -pe 's/foo/bar/'
```

<br />



#### Substitute (find and replace) all "foo"s with "bar" on each line
```bash
perl -pe 's/foo/bar/g'
```

<br />



#### Substitute (find and replace) "foo" with "bar" on lines that match "baz"
```bash
perl -pe '/baz/ && s/foo/bar/'
```

<br />



#### Binary patch a file (find and replace a given array of bytes as hex numbers)
```bash
perl -pi -e 's/\x89\xD8\x48\x8B/\x90\x90\x48\x8B/g' file
```

<br />




# SELECTIVE PRINTING AND DELETING OF CERTAIN LINES


#### Print the first line of a file (emulate head -1)
```bash
perl -ne 'print; exit'
```

<br />



#### Print the first 10 lines of a file (emulate head -10)
```bash
perl -ne 'print if $. <= 10'
```

<br />


```bash
perl -ne '$. <= 10 && print'
```

<br />


```bash
perl -ne 'print if 1..10'
```

<br />



#### Print the last line of a file (emulate tail -1)
```bash
perl -ne '$last = $_; END { print $last }'
```

<br />


```bash
perl -ne 'print if eof'
```

<br />



#### Print the last 10 lines of a file (emulate tail -10)
```bash
perl -ne 'push @a, $_; @a = @a[@a-10..$#a]; END { print @a }'
```

<br />



#### Print only lines that match a regular expression
```bash
perl -ne '/regex/ && print'
```

<br />



#### Print only lines that do not match a regular expression
```bash
perl -ne '!/regex/ && print'
```

<br />



#### Print the line before a line that matches a regular expression
```bash
perl -ne '/regex/ && $last && print $last; $last = $_'
```

<br />



#### Print the line after a line that matches a regular expression
```bash
perl -ne 'if ($p) { print; $p = 0 } $p++ if /regex/'
```

<br />



#### Print lines that match regex AAA and regex BBB in any order
```bash
perl -ne '/AAA/ && /BBB/ && print'
```

<br />



#### Print lines that don't match match regexes AAA and BBB
```bash
perl -ne '!/AAA/ && !/BBB/ && print'
```

<br />



#### Print lines that match regex AAA followed by regex BBB followed by CCC
```bash
perl -ne '/AAA.*BBB.*CCC/ && print'
```

<br />



#### Print lines that are 80 chars or longer
```bash
perl -ne 'print if length >= 80'
```

<br />



#### Print lines that are less than 80 chars in length
```bash
perl -ne 'print if length < 80'
```

<br />



#### Print only line 13
```bash
perl -ne '$. == 13 && print && exit'
```

<br />



#### Print all lines except line 27
```bash
perl -ne '$. != 27 && print'
```

<br />


```bash
perl -ne 'print if $. != 27'
```

<br />



#### Print only lines 13, 19 and 67
```bash
perl -ne 'print if $. == 13 || $. == 19 || $. == 67'
```

<br />


```bash
perl -ne 'print if int($.) ~~ (13, 19, 67)' 
```

<br />



#### Print all lines between two regexes (including lines that match regex)
```bash
perl -ne 'print if /regex1/../regex2/'
```

<br />



#### Print all lines from line 17 to line 30
```bash
perl -ne 'print if $. >= 17 && $. <= 30'
```

<br />


```bash
perl -ne 'print if int($.) ~~ (17..30)'
```

<br />


```bash
perl -ne 'print if grep { $_ == $. } 17..30'
```

<br />



#### Print the longest line
```bash
perl -ne '$l = $_ if length($_) > length($l); END { print $l }'
```

<br />



#### Print the shortest line
```bash
perl -ne '$s = $_ if $. == 1; $s = $_ if length($_) < length($s); END { print $s }'
```

<br />



#### Print all lines that contain a number
```bash
perl -ne 'print if /\d/'
```

<br />



#### Find all lines that contain only a number
```bash
perl -ne 'print if /^\d+$/'
```

<br />



#### Print all lines that contain only characters
```bash
perl -ne 'print if /^[[:alpha:]]+$/'
```

<br />



#### Print every second line
```bash
perl -ne 'print if $. % 2'
```

<br />



#### Print every second line, starting the second line
```bash
perl -ne 'print if $. % 2 == 0'
```

<br />



#### Print all lines that repeat
```bash
perl -ne 'print if ++$a{$_} == 2'
```

<br />



#### Print all unique lines
```bash
perl -ne 'print unless $a{$_}++'
```

<br />



#### Print the first field (word) of every line (emulate cut -f 1 -d ' ')
```bash
perl -alne 'print $F[0]'
```

<br />




# HANDY REGULAR EXPRESSIONS


#### Match something that looks like an IP address
/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
/^(\d{1,3}\.){3}\d{1,3}$/

#### Test if a number is in range 0-255
/^([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$/

#### Match an IP address
my $ip_part = qr|([0-9]|[0-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])|;
if ($ip =~ /^($ip_part\.){3}$ip_part$/) {
 say "valid ip";
}

#### Check if the string looks like an email address
/\S+@\S+\.\S+/

#### Check if the string is a decimal number
/^\d+$/
/^[+-]?\d+$/
/^[+-]?\d+\.?\d*$/

#### Check if the string is a hexadecimal number
/^0x[0-9a-f]+$/i

#### Check if the string is an octal number
/^0[0-7]+$/

#### Check if the string is binary
/^[01]+$/

#### Check if a word appears twice in the string
/(word).*\1/

#### Increase all numbers by one in the string
$str =~ s/(\d+)/$1+1/ge

#### Extract HTTP User-Agent string from the HTTP headers
/^User-Agent: (.+)$/

#### Match printable ASCII characters
/[ -~]/

#### Match unprintable ASCII characters
/[^ -~]/

#### Match text between two HTML tags
m|<strong>([^<]*)</strong>|
m|<strong>(.*?)</strong>|

#### Replace all <b> tags with <strong>
$html =~ s|<(/)?b>|<$1strong>|g

#### Extract all matches from a regular expression
my @matches = $text =~ /regex/g;


PERL TRICKS
-----------

#### Print the version of a Perl module
```bash
perl -MModule -le 'print $Module::VERSION'
```

<br />


```bash
perl -MLWP::UserAgent -le 'print $LWP::UserAgent::VERSION'
```

<br />

