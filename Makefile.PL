
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'App::moduleshere',
                       'DISTNAME' => 'App-moduleshere',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'sunnavy <sunnavy@bestpractical.com>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'copy modules(.pm) to cwd or somewhere',
                       'EXE_FILES' => [
                                        'bin/mhere'
                                      ],
                       'VERSION' => '0.04',
                       'PREREQ_PM' => {},
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



