ARCHIVE="http://storage.poesis.kr/downloads/post/postcodify.20141112.v2.sqlite.xz"
echo "Downloading postcodify database file ..."
wget $ARCHIVE || curl -OL $ARCHIVE
echo "Decompressing file ..."
xz -d postcodify.20141112.v2.sqlite.xz
mkdir -p db
mv postcodify.20141112.v2.sqlite db/
echo "Sucessfully Installed db/postcodify.20141112.v2.sqlite"
echo "Bye!"
