#!/usr/bin/perl
###################################
# By: Ventz Petkov                #
# Date: 01-05-11                  #
# Last: 01-02-13                  #
# Parses HTML + Long URLs in MUTT #
###################################

use URI::Escape;
$file = $ARGV[0];
@text = ();

# Only shorten URLs at least this length or more
$tinyurltrigger = 120;

# If we pass a 2nd argument, it means we want to force HTML check a 'text/plain' file
if(defined($ARGV[2])) { open(FP, $file); for(<FP>) { push(@text, $_); } close(FP); }
# Otherwise, treat as HTML first 
else { @text = `w3m -dump -o display_link_number=1 -o document_charset=$ARGV[1] $file`; }


# Note: using while (instead of for) b/c for supposedly loads
# everything into memory - no reason to load large emails into memory

while (my $line = shift @text) {
	next if($line =~ /mailto:/);
	if($line =~ /(\w+:\/\/\S+)/) {
		my $link = $1;
		chomp($link);
		$size = length($link);
		if($size >= $tinyurltrigger) {
			eval {
				my $alarm = 5;
				alarm $alarm;
				my $link = uri_escape($link);
				$tinyurl=`curl -s http://tinyurl.com/api-create.php?url=$link`;
				alarm 0;
			};

			if ($@) { 
				$line =~ s/(\w+:\/\/\S+)/$link (curl TimeOut)/; }
			else { $line =~ s/(\w+:\/\/\S+)/$tinyurl\n\t[>> $link <<]/; }
		}
	}
	print "$line";
}


exit 0;
