Accepts an array reference, a limit, and up to 3 column indexes. Will return array refeernce that has less elements than the limit and where the vals in the cols specified have been averaged to represent the original array as a whole

sub averagify_array_from_ref_cols
{
	my $array_ref = $_[0];
	my $limit = $_[1];
	my $col_to_avg_1 = $_[2];
	my $col_to_avg_2 = $_[3];
	my $col_to_avg_3 = $_[4];

	$limit = 100 if !$limit;

	my $data_length = @$array_ref;

	my @array_ref_avg = ();

	my $group_by = ceil($data_length / $limit);
	my $current = 0;

	while ($current >= 0){

		my $end = $current+$group_by;
		my $num_in_group = 0;
		my $col_sum_1 = 0;				
		my $col_sum_2 = 0;				
		my $col_sum_3 = 0;				

		for my $c($current..($end-1)){
			if($c > $data_length || $array_ref->[$c][$col_to_avg_1] eq ''){ $current = -1 ; last;}
			$num_in_group++;
			$col_sum_1 = $col_sum_1+$array_ref->[$c][$col_to_avg_1];
			$col_sum_2 = $col_sum_2+$array_ref->[$c][$col_to_avg_2] if $col_to_avg_2 ne '';
			$col_sum_3 = $col_sum_3+$array_ref->[$c][$col_to_avg_3] if $col_to_avg_3 ne '';
		}
		last if $current == -1;
		$array_ref->[$current][$col_to_avg_1] = int($col_sum_1/$num_in_group);
		$array_ref->[$current][$col_to_avg_2] = int($col_sum_2/$num_in_group) if $col_to_avg_2 ne '';
		$array_ref->[$current][$col_to_avg_3] = int($col_sum_3/$num_in_group) if $col_to_avg_3 ne '';
		push(@array_ref_avg,$array_ref->[$current]);
		$current = $end;

	}

	$array_ref = \@array_ref_avg;
	return $array_ref;
}
