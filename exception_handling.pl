use strict;
use warnings;
# usage of Error.pm including try/catch paradigm support
use Error qw(:try);
# require to obtain stack traces
local $Error::Debug = 1;

=pod

=head1 DESCRIPTION

This program demonstrates handling exceptions using the Error.pm module
and obtaining a stack trace to aid in debugging.

=cut

# several layers of function calls demonstrate effective stack traces
sub xyz {
  yyy(@_);
}

sub yyy {
  zzz(@_);
}

sub zzz {
  # where the actual error is thrown
  throw Error::Simple("Danger, Will Robinson!");
}

################ Example 1
try {
  xyz();
# handle any non-specific exceptions
} otherwise {
  my $ex = shift;
  print("Handling generic error\n");
  print ($ex->stacktrace);
} finally {
  print "Cleaning up\n";
}

################ Example 2
try {
  xyz();
# specific exception handling
} catch Error::Simple with {
  print("handling a specific type of error");
}

