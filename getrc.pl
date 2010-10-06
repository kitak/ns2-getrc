#!/usr/bin/perl

# system defaults
$event="r";
$ftype="tcp";
$fid=2;
$from=1;
$to=2;

# Process command line args.
while ($_ = $ARGV[0], /^-/)
{
  shift;
  if (/^-h/)      { $Usage; }
  elsif (/^-e/)  { if ( $ARGV[0] ne '' ) {
                      $event = $ARGV[0];  
                      shift; }}
  elsif (/^-t/)  { if ( $ARGV[0] ne '' ) {
                      $ftype = $ARGV[0];  
                      shift; }}
  elsif (/^-f/)  { if ( $ARGV[0] ne '' ) {
                      $fid = $ARGV[0];  
                      shift; }}
  elsif (/^-s/)  { if ( $ARGV[0] ne '' ) {
                      $from = $ARGV[0];  
                      shift; }}
  elsif (/^-d/)  { if ( $ARGV[0] ne '' ) {
                      $to = $ARGV[0];  
                      shift; }}
  else            { warn "$_ bad option\n"; &Usage; }
}

# Now, make sure one and only one filename was specified
if (($ARGV[0] eq '') || ($ARGV[1] ne '')) {
  	warn "Need to specify one and only one filename\n";
  	&Usage;
}
$infile = $ARGV[0];

open (DATA,"<$infile") || die "Can't open $infile $!";

while (<DATA>) {
	@x = split(' ');
	
	if($x[0] eq $event && $x[2]==$from && $x[3]==$to && $x[4] eq $ftype && $x[7]==$fid) {
        print "@x\n";
	}
}
close DATA;
exit 0;

# print usage and quit
sub Usage {
  	printf STDERR "usage: jitter.pl [flags] <trace filename>, where:\n";
  	printf STDERR "\t-e  event type (default r)\n"; 
  	printf STDERR "\t-t  {tcp|cbr} flow type (default tcp)\n";
    printf STDERR "\t-f  flow id (default 2)\n";
  	printf STDERR "\t-s #         start link bottlneck router (default 1)\n";
  	printf STDERR "\t-d #         end link bottlneck router (default 2)\n";
  	printf STDERR "\t-h            this help message\n";

  	exit(1);
}
