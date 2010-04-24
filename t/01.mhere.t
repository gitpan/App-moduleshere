use strict;
use warnings;

use Test::More tests => 9;
use File::Temp 'tempdir';
use FindBin;
use File::Spec::Functions qw/catfile updir/;
my $mhere = catfile( $FindBin::Bin, updir, '/bin/mhere' );

my $dir = tempdir( CLEANUP => 1 );
local $ENV{APP_MODULES_HERE} = $dir;
my $usage = <<'EOF';
USAGE: mhere Module [ ... ]
EXAMPLES:
    mhere Carp                                    # copy Carp.pm in @INC to cwd
    mhere Carp CGI                                # copy both Carp.pm and CGI.pm
    APP_MODULES_HERE=outlib mhere Carp            # copy to outlib dir in cwd
    APP_MODULES_HERE=/tmp/ mhere Carp             # copy to /tmp/
EOF

is( `$^X $mhere`,        $usage, 'mhere without args shows usage' );
is( `$^X $mhere -h`,     $usage, 'mhere -h shows useage too' );
is( `$^X $mhere -h Foo`, $usage, 'mhere -h Foo shows usage too' );

is( `$^X $mhere strict`, 'copied module(s): strict' . "\n", 'mhere strict' );
is(
    `$^X $mhere File::Spec::Functions`,
    'copied module(s): File::Spec::Functions' . "\n",
    'mhere File::Spec::Functions'
);

open my $ori_fh, '<', $INC{'strict.pm'} or die $!;
open my $new_fh, '<', catfile( $dir, 'strict.pm' ) or die $!;

{
    local $/;
    is( <$ori_fh>, <$new_fh>, 'copied strict.pm is indeed a copy' )
}

open $ori_fh, '<', $INC{'File/Spec/Functions.pm'} or die $!;
open $new_fh, '<', catfile( $dir, 'File', 'Spec', 'Functions.pm' ) or die $!;

{
    local $/;
    is( <$ori_fh>, <$new_fh>, 'copied File/Spec/Functions.pm is indeed a copy' )
}

is(
    `$^X $mhere strict File::Spec::Functions`,
    'copied module(s): strict, File::Spec::Functions' . "\n",
    'mhere strict, File::Spec::Functions'
);

# test if the source and the destination is the same file
is(
    `$^X -I$dir $mhere strict`,
    '0 modules are copied' . "\n",
    "don't copy if the source and destination are the same path"
);

