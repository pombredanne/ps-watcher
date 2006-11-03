#!/usr/bin/perl -w
# $Id: args.t.in,v 1.8 2006/03/10 13:12:36 rockyb Exp $
# Arg checks
use strict;
use Test::More;
use Config;

if ('cygwin' eq $Config{osname}) {
    plan( skip_all => "cygwin's ps is not powerful enough this test");
    exit 0;
}

plan( tests => 2);

my $test='args';

my $srcdir = $ENV{srcdir} ? $ENV{srcdir} : '.';
my $cmd = "/usr/bin/perl ../ps-watcher --log --nosyslog --nodaemon " 
        . " --sleep -1 --config ${srcdir}/$test.cnf";
my @output = `$cmd 2>&1`;

# First line is Id line. This doesn't count in testing.
shift @output;

my $count=0;
foreach (@output) {
  if (/^.+:\s+.*ok/) {
    s/.+:\s+//;
    ok(1, "Saw first matching process");
    $count++;
    last;
  }  
}
ok($count>0, "Saw more than one matching process");

#;;; Local Variables: ***
#;;; mode:perl ***
#;;; End: ***
