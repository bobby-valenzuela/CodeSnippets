# Hello World Program in Perl
#
print "Hello World!\n";


package Person;
sub new {
   my $class = shift;
   my $self = {
      _firstName => shift,
      _lastName  => shift,
      _ssn       => shift,
   };

    sub getFirstName {
       return $self->{_firstName};
    }

   bless $self, $class;
   return $self;
}








my $dev_main = new Person("Mr", "Hacker", 123456);
print "his SSN is $dev_main->{_ssn}\n";

my $hacker_name = $dev_main->getFirstName(); 

print "Now his name is... $hacker_name\n";

1;
