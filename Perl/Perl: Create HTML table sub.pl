sub create_table_from_headdata_bodydata
{
	my $th_data = $_[0];
	my $tr_data = $_[1];

	my $table_header = my $table_body = '';

	for my $h ( 0 .. $#{$th_data}){
		$table_header .= qq(
			<div class="w-100">
			<table class="table table-hover">
				<thead>
					<tr>
		) if $h == 0;
		$table_header .= "<th class='text-center'>$th_data->[$h]</th>";
		$table_header .= "</tr></thead><tbody>" if $h == $#{$th_data};
	}

	for my $r ( 0 .. $#{$tr_data}){

		my $tds = '';
		for my $d ( 0 .. $#{$tr_data->[$r]} ){ $tds .= "<td class='text-center'>$tr_data->[$r][$d]</td>";} 

		$table_body .= "<tr>$tds</tr>";
		$table_body .= "</tbody></table></div>" if $r == $#{$tr_data};

	}
	my $table = $table_body eq '' ? '<div id="msg" class="text-center w-100">Sorry, no data to display.</div>' : "$table_header $table_body";
	return "$table";
}

# Example
$table_headers = ['Name','Age','Email'];
$table_body = [
    ['Joe', 21, 'joe@somecoolemail.com'],
    ['Bill', 22, 'bill@somecoolemail.com'],
    ['Dude', 23, 'dude@somecoolemail.com']
];
$my_awesome_table = &create_table_from_headdata_bodydata($table_headers, $table_body);
