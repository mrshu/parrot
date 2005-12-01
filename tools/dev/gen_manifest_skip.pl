#! perl -w
# Copyright: 2005 The Perl Foundation.  All Rights Reserved.
# $Id$

=head1 NAME

tools/dev/gen_manifest_skip.pl - generated the file MANIFEST.SKIP

=head1 SYNOPSIS

    % perl tools/dev/gen_manifest_skip.pl > MANIFEST.SKIP

=head1 DESCRIPTION

Goes through the Parrot directories and ask about the svn:ignore property.
Print content for a MANIFEST.SKIP file to STDOUT.

=cut

use strict;
use FindBin;
use lib "$FindBin::Bin/../../lib";

use Data::Dumper;
use Parrot::Distribution;

my $dist = Parrot::Distribution->new();

my $skip = $dist->gen_manifest_skip();

my $header = '# $' . 'Id' . '$' . "\n" . << 'END_HEADER';   # confuse SVN
# generated by tools/dev/gen_manifest_skip.pl NOW
#
# This file should contain a transcript of the svn:ignore properties
# of the directories in the Parrot subversion repository. (Needed for
# distributions or in general when svn is not available).
# See docs/submissions.pod on how to recreate this file after SVN
# has been told about new generated files.
# 
# Ignore the SVN directories
\B\.svn\b

# debian/ should not go into release tarballs
^debian$
^debian/
END_HEADER
my $now = localtime();
$header =~ s/NOW/$now/;

print join( "\n", $header, @{$skip}, '' );

=head1 AUTHOR

Bernhard Schmalhofer - <Bernhard.Schmalhofer@gmx.de>

=cut
