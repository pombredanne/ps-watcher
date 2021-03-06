#!/usr/bin/perl -w
# $Id: basic.t.in,v 1.8 2006/03/10 19:07:06 rockyb Exp $
# Some basic checks
use strict;
use Test::More;

if ( 'etime' ) {
    plan( tests => 5);
} else {
    plan( tests => 4 );
}

my $test='basic';
my $cmd = "/usr/bin/perl ../ps-watcher --log --nosyslog --nodaemon " 
        . "--sleep -1 --config $test.cnf";
my @output = `$cmd 2>&1`;

# First line is Id line. This doesn't count in testing.
shift @output;

my $i=1;
foreach (@output) {
  s/.+:\s+//;
  $i++ if (!'etime' && $i==3);
  my $result = sprintf "ok %d", $i;
  $i++;
  ok($_ =~ m{$result});
}

#;;; Local Variables: ***
#;;; mode:perl ***
#;;; End: ***
