#!/usr/bin/perl -w
use strict;
use warnings;
use File::Find;
use Getopt::Long;
use Digest::SHA qw(sha1_hex);


# Variable definition
my $sha;
my $path;
my $file;
my $digest;
my $extension;


# Get option(s)
my @result = GetOptions(
	'd=s'	=> \$path
) or die("Error in command line arguments\n");

unless ($path){
	print("Usage: perl $0 -d [/folder]\n");
	exit;
}

# Execute the process_file methode
find(\&process_file,$path);


# Write here what to do ...
sub process_file {
	$file = $File::Find::name;
	
	if( -f $file) {
		$sha = Digest::SHA->new(1);	
		$sha->addfile($file);
		$digest = $sha->hexdigest;
		($extension) = $_ =~ /(\.[^.]+)$/;
	
		rename $File::Find::name, "$File::Find::dir/$digest" . $extension; 
		print "- $file as been renamed to $digest" . $extension . "\n";
    }
}

print "\n 	--- WORK DONE... MASTER ;) --- \n";
