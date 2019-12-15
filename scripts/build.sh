#!/usr/bin/env bash
# Use set -o errexit (a.k.a. set -e) to make your script exit when a command fails.
# Then add || true to commands that you allow to fail.
set -o errexit
# Use set -o pipefail in scripts to catch mysqldump fails in e.g. mysqldump |gzip. The exit status of the last command that threw a non-zero exit code is returned.
set -o pipefail
# Use set -o nounset (a.k.a. set -u) to exit when your script tries to use undeclared variables.
set -o nounset



echo -n "What's the project scope: "
read -r NPM_PACKAGE_SCOPE

echo -n "What's the project name: "
read -r NPM_PACKAGE_NAME

echo -n "What's the project description: "
read -r PROJECT_DESCRIPTION

echo -n "What's the git repository: "
read -r GIT_REPO

PROJECT_NAME="$NPM_PACKAGE_SCOPE-$NPM_PACKAGE_NAME"


echo "NPM_PACKAGE_SCOPE=$NPM_PACKAGE_SCOPE"
echo "NPM_PACKAGE_NAME=$NPM_PACKAGE_NAME"
echo "PROJECT_DESCRIPTION=$PROJECT_DESCRIPTION"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "GIT_REPO=$GIT_REPO"

: "${BUILD_DIR:="./build"}"
: "${BUILD_PROJECT_DIR:="${BUILD_DIR}/${PROJECT_NAME}"}"


rm -rf "${BUILD_PROJECT_DIR}"
mkdir -p "${BUILD_PROJECT_DIR}"
cp -R "template/." "${BUILD_PROJECT_DIR}"

# find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 echo



readonly SED_NPM_PACKAGE_SCOPE="s/NPM_PACKAGE_SCOPE/${NPM_PACKAGE_SCOPE}/g"
readonly SED_NPM_PACKAGE_NAME="s/NPM_PACKAGE_NAME/${NPM_PACKAGE_NAME}/g"
readonly SED_PROJECT_DESCRIPTION="s/PROJECT_DESCRIPTION/${PROJECT_DESCRIPTION}/g"
readonly SED_PROJECT_NAME="s/PROJECT_NAME/${PROJECT_NAME}/g"
readonly SED_GIT_REPO="s/GIT_REPO/${GIT_REPO}/g"



find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_NPM_PACKAGE_SCOPE}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_NPM_PACKAGE_NAME}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_PROJECT_DESCRIPTION}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_PROJECT_NAME}"
# find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_GIT_REPO}"


