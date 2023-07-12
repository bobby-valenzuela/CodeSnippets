use JSON;
use Data::Dumper;

sub json_string_to_hash
{
    my $json_string = $_[0];
    my $json = JSON->new->allow_nonref;
    my $json_hash_scalar = $json->decode( $json_string ); # Same as calling decode_json($json_string)
    my %json_hash = %$json_hash_scalar;
    return %json_hash;
}

my $json_string = qq(
	{
		"name":"M.Scott",
		"age": 0,
		"hobbies": [
			"hockey", "making threat level midnight","cheese puffs"
		]	
	}
);

%json = json_string_to_hash($json_string);


$json{'Special Skills'} = "Sales";

# Make JSON String
$decoded = encode_json(\%json);

print "JSON STRING => \t$decoded\n";

# Make JSON Object
$json_obj = to_json(\%json);

print "JSON OBJECT => \t";
print Dumper $json_obj;
