#/bin/bash

# distp from Mapr to HDP (root user)
# Make adjustments to the protocol_prefix.sh file to control source and dest. filesystems.
# Get the SOURCE and TARGET protocol prefix's
if [ -f ../misc/protocol_prefix.sh ]; then
. ../misc/protocol_prefix.sh
else
    echo "Couldn't find ../misc/protocol_prefix.sh.  Needed to set cluster name information for transfers"
    exit -1
fi

while [ $# -gt 0 ]; do
  case "$1" in
    --section)
      shift
      SECTION=$1
      shift
      ;;
    --help)
      echo "Usage: $0 --section <section>
      exit -1
      ;;
    *)
      break
      ;;
  esac
done

if [ "$SECTION" == "" ]; then
  echo "Need to specify a section to transfer.  This is from the "build_check_files.sh" run."
  exit -1
fi

hadoop distcp -i -pugp -delete -update $SOURCE/user/root/validation/$SECTON $TARGET/user/root/validation/$SECTION

if [ -d $SECTION/mapr ]; then
  rm -rf $SECTION/mapr
fi

hdfs dfs -get validation/$SECTION/mapr .