  # ADD TO OUR LIST
  if (exists $agreements_updated{"$agreementid"}){
      $agreements_updated{"$agreementid"}->[$#{$agreements_updated{"$agreementid"}} + 1] = $additionid;
  }else{
      $agreements_updated{"$agreementid"} = [$additionid];
  }
			
			
    foreach (keys %agreements_updated){
        # foreach my $array(@{$agreements_updated{$_}}){
        ##do something with $array;
        # }
        my $this_agreement = $agreements_updated{$_};

        for my $a (0..$#{$this_agreement}){

            print "Additionid: $this_agreement->[$a] \n";

        }

        # print "key: $_ \n"; 
    }
