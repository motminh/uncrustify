#! /bin/sh
#
# Scans src/token_enum.h and creates token_names.h
#
# $Id$
#

infile="token_enum.h"
outfile="token_names.h"

if [ -d src ] ; then
  infile="src/"${infile}
  outfile="src/"${outfile}
fi

# do a little trick to prevent CVS from expanding the id tag
idstr="Id: $"

cat > $outfile <<EOF
/*
 * Generated by `basename $0` on `date`
 * \$$idstr
 */

#ifndef TOKEN_NAMES_H_INCLUDED
#define TOKEN_NAMES_H_INCLUDED

const char *token_names[] =
{
EOF

# Print lines from infile that contain CT_, stripping everything after ','
# and formating the result as a quoted C string.
sed -n '/ *CT_/s/CT_\([^,]*\),.*/"\1",/p' $infile >>$outfile

cat >> $outfile <<EOF
};

#endif  /* TOKEN_NAMES_H_INCLUDED */

EOF

