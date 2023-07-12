use Encode;

# If working with utf-8 (which we aren't) decode utf8
my $var = decode_utf8("Sup’");

if( $var =~ m/\x{2019}/g ){
    print "YES-UTF\n";
}

# If working with unicode (which we are) encode as utf8
my $var2 = encode_utf8("\x{2019}");


if( $var2 =~ m/\xe2\x80\x99/g ){
    print "YES-UNI\n";
}
