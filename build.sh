#!/bin/bash
DEPLOYMENT_FILE="kubernetes/nginx.yml"
PACKAGE_NAME="solarwind-nginx"
echo "Package name is $PACKAGE_NAME"
CURRENT_VERSION=$(awk -F 'image: vhalme/|:x86' '/image: vhalme/{sub(/^_/, "", $3); print $3}' "$DEPLOYMENT_FILE")
echo "Current version is $CURRENT_VERSION"
CURRENT_MINOR_VERSION=$(echo "$CURRENT_VERSION" | awk -F'.' '{print $NF}')
echo "Current minor version is $CURRENT_MINOR_VERSION"
NEW_MINOR_VERSION=$((CURRENT_MINOR_VERSION + 1))
echo "New minor version is $NEW_MINOR_VERSION"
NEW_VERSION=$(echo "$CURRENT_VERSION" | sed "s/\.[0-9]*$/.$NEW_MINOR_VERSION/")
echo "New version is $NEW_VERSION"
sed "s/x86_$CURRENT_VERSION/x86_$NEW_VERSION/" < "$DEPLOYMENT_FILE" > "tmp.yml" && mv "tmp.yml" "$DEPLOYMENT_FILE"
echo "Updated image version from x86_$CURRENT_VERSION to x86_$NEW_VERSION in $DEPLOYMENT_FILE."
NEW_IMAGE_NAME="vhalme/$PACKAGE_NAME:x86_$NEW_VERSION"
echo "New image name is $NEW_IMAGE_NAME"
docker images -q vhalme/$PACKAGE_NAME | xargs docker rmi
echo "Building $NEW_IMAGE_NAME"
docker buildx build --platform=linux/amd64 -t $NEW_IMAGE_NAME . --no-cache
docker push $NEW_IMAGE_NAME

