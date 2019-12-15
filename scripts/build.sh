#!/usr/bin/env bash
# Use set -o errexit (a.k.a. set -e) to make your script exit when a command fails.
# Then add || true to commands that you allow to fail.
set -o errexit
# Use set -o pipefail in scripts to catch mysqldump fails in e.g. mysqldump |gzip. The exit status of the last command that threw a non-zero exit code is returned.
set -o pipefail
# Use set -o nounset (a.k.a. set -u) to exit when your script tries to use undeclared variables.
set -o nounset


echo -n "What's the project name: "
read -r PROJECT_NAME
echo "PROJECT_NAME=$PROJECT_NAME"


: "${BUILD_DIR:="./build"}"
: "${BUILD_PROJECT_DIR:="${BUILD_DIR}/${PROJECT_NAME}"}"


rm -rf "${BUILD_PROJECT_DIR}"
mkdir -p "${BUILD_PROJECT_DIR}"
cp -R "template/." "${BUILD_PROJECT_DIR}"

find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 echo

find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "s/PROJECT_NAME/${PROJECT_NAME}/g"

# find "${BUILD_PROJECT_DIR}" -type f -exec sed -i "s/PROJECT_NAME/${PROJECT_NAME}/g" {} +
# find "${BUILD_PROJECT_DIR}" -type f -exec sed -i "s/PROJECT_NAME/${PROJECT_NAME}/g" {} \;

