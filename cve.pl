#!/usr/bin/perl 
#Mustafa -> Twitter : @c0brabaghdad1

use strict;
use warnings;
use LWP::UserAgent;
use Getopt::Long;
use Term::ANSIColor;


my $options = GetOptions(
  'u=s' => \my $url,
  'l=s' => \my $list,
  'd=s' => \my $dir
) or die "Invalid options passed to $0\n";

if (defined($list)) {
	chomp $list;
	if(open(LIST,'<', $list)or die $!){
		while(my $custom_wordlist = <LIST>){
			chomp $custom_wordlist;
			if($custom_wordlist !~ /^https?:/){
		        $custom_wordlist = 'http://'.$custom_wordlist;
            }
			my $full_url = $custom_wordlist.'/'.$dir;
			my $req = HTTP::Request->new(GET=>$full_url);
			my $ua = LWP::UserAgent->new(timeout => 10);
			my $page = $ua->request($req);
			my $status_code = $page->code();
			if($status_code == 200 ){
					print color 'BRIGHT_GREEN';
					print "[+] 200 Found -> ";
					print $full_url, "\n";
					print color 'reset';
			}
			else {
					print color 'red';
					print "[*] HTTP ", $page->code(), "  -> ";
					print $full_url, "\n";
					print color 'reset';
			}	
		}	
	}	
}  
if (defined($url)) {
   chomp $url;
   if($url !~ /^https?:/){
		$url = 'http://'.$url;
    }
   my $full_url = $url.'/'.$dir;
   my $req = HTTP::Request->new(GET=>$full_url);
   my $ua = LWP::UserAgent->new(timeout => 10);
   my $page = $ua->request($req);
   my $status_code = $page->code(); 
            if($status_code == 200 ){
					print color 'BRIGHT_GREEN';
					print "[+] 200 Found -> ";
					print $full_url, "\n";
					print color 'reset';
			}
            else {
					print color 'red';
					print "[*] HTTP ", $page->code(), "  -> ";
					print $full_url, "\n";
					print color 'reset';
			}	
}

if(!defined($url) or !defined($list) or !defined($dir)){
	print color "BRIGHT_CYAN";
	print "\n\n************* Usage *************\n";
	print "cve.pl -d DIR -u URL  \n";
	print "cve.pl -d DIR  -l list.txt\n";
	print color 'reset';
    exit 1;}