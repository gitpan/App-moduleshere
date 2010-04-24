package App::moduleshere;

use warnings;
use strict;
our $VERSION = '0.04';

1;

__END__

=head1 NAME

App::moduleshere - copy modules(.pm) to cwd or somewhere

=head1 SYNOPSIS

    mhere Carp                                    # copy Carp.pm in @INC to cwd
    mhere Carp CGI                                # copy both Carp.pm and CGI.pm
    APP_MODULES_HERE=outlib mhere Carp            # copy to outlib dir in cwd
    APP_MODULES_HERE=/tmp/ mhere Carp             # copy to /tmp/

=head1 DESCRIPTION

This small script(C<mhere>) helps you copy modules to somewhere you like.
by default, it will copy to your current working directory.

It's first written when I tried to trace a bug in one of my modules which 
led me to the other module(let's call it C<Foo> here) in C<@INC>.

So I ran C<perldoc -l Foo> to find its path, edited it to add more debug
info, forced save it(happy that I had the write permission),
then reproduced the bug to go on debugging, and so on.

After fixed the bug, I was happy and decided to do something
else, I almost forgot that I changed C<Foo> before!
(believe me, I totally forgot it a couple of times)
So I switched to C<Foo>, reversed all changed I've made, and forced save
it again. 

That was a bad experience so I decided to make a new approach. that is,
to copy relative modules to current working directory and make changes there.
after all done we can just remove it with a clean, untouched C<@INC>.
The new one is better, at least for me, wish it can help you too :)

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

=head1 AUTHOR

<sunnavy>  C<< <<sunnavy@bestpractical.com>> >>


=head1 LICENCE AND COPYRIGHT

Copyright 2010 Best Practical Solutions.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

