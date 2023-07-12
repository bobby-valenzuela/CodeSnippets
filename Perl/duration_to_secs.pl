
=cut
Works For:
dd:hh:mm:ss
hh:mm:ss
mm:ss
ss
=cut

my $duration = "01:00:00:00";

my ($days, $hours, $minutes, $seconds) = split(/:/, $duration);

# If missing mins + secs, then we received mm:ss - shifts fields by 2
if($hours eq '' && $minutes eq '' && $seconds eq ''){

    $seconds = $days;
    $minutes = 0;
    $days = 0;
    $hours = 0;
}
elsif($minutes eq '' && $seconds eq ''){

    $seconds = $hours;
    $minutes = $days;
    $days = 0;
    $hours = 0;
}
# If missing secs, then we received hh:mm:ss - shifts fields by 1
elsif($seconds eq ''){

    $seconds = $minutes;
    $minutes = $hours;
    $hours = $days;
    $days = 0;
}

my $total_seconds = ($days * 86400) + ($hours * 3600) + ($minutes * 60) + $seconds;
# my $total_seconds = $days * 24 * 60 * 60 + $hours * 60 * 60 + $minutes * 60 + $seconds;
# my $total_seconds = $days * 86_400 + $hours * 3_600 + $minutes * 60 + $seconds;

print "Total seconds: $total_seconds\n";
