cat thread0*.log > thread.log
sort -k 2 -n thread.log > result.log
vi result.log
rm thread*.log