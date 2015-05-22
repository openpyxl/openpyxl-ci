PLATFORM=$(uname)

if [ "$PLATFORM" = Darwin ]; then
    USER_GROUP=50
    USER_ID=1000
else
    USER_GROUP=$(id -g)
    USER_ID=$(id -u)
fi

echo "me:x:$USER_ID:$USER_GROUP:,,,:/tmp:/bin/bash" > passwd.minimal
docker build -t $(basename $PWD) .
