#!/usr/bin/env bash
# Use set -o errexit (a.k.a. set -e) to make your script exit when a command fails.
# Then add || true to commands that you allow to fail.
set -o errexit
# Use set -o pipefail in scripts to catch mysqldump fails in e.g. mysqldump |gzip. The exit status of the last command that threw a non-zero exit code is returned.
set -o pipefail
# Use set -o nounset (a.k.a. set -u) to exit when your script tries to use undeclared variables.
set -o nounset

echo -n "What's the project scope: "
read -r PROJECT_SCOPE

echo -n "What's the project name: "
read -r PROJECT_NAME

echo -n "What's the project description: "
read -r PROJECT_DESCRIPTION

GIT_REPO_BASE_URL="https://github.com"
GIT_REPO_USER="maspio"
GIT_REPO_NAME="$PROJECT_SCOPE-$PROJECT_NAME"
GIT_REPO_URL="$GIT_REPO_BASE_URL/$GIT_REPO_USER/$GIT_REPO_NAME"


echo "PROJECT_SCOPE=$PROJECT_SCOPE"
echo "PROJECT_NAME=$PROJECT_NAME"
echo "PROJECT_DESCRIPTION=$PROJECT_DESCRIPTION"
echo "GIT_REPO_USER=$GIT_REPO_USER"
echo "GIT_REPO_NAME=$GIT_REPO_NAME"
echo "GIT_REPO_URL=$GIT_REPO_URL"

: "${BUILD_DIR:="./build"}"
: "${BUILD_PROJECT_DIR:="${BUILD_DIR}/${GIT_REPO_NAME}"}"

rm -rf "${BUILD_PROJECT_DIR}"
mkdir -p "${BUILD_PROJECT_DIR}"
cp -R "template/." "${BUILD_PROJECT_DIR}"

readonly SED_PROJECT_SCOPE="s/PROJECT_SCOPE/${PROJECT_SCOPE}/g"
readonly SED_PROJECT_NAME="s/PROJECT_NAME/${PROJECT_NAME}/g"
readonly SED_PROJECT_DESCRIPTION="s/PROJECT_DESCRIPTION/${PROJECT_DESCRIPTION}/g"
readonly SED_GIT_REPO_NAME="s/GIT_REPO_NAME/${GIT_REPO_NAME}/g"
readonly SED_GIT_REPO_URL="s,GIT_REPO_URL,${GIT_REPO_URL},g"


# find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 echo

find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_PROJECT_SCOPE}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_PROJECT_NAME}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_PROJECT_DESCRIPTION}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_GIT_REPO_NAME}"
find "${BUILD_PROJECT_DIR}" -type f -print0 | xargs -0 sed -i '' "${SED_GIT_REPO_URL}"

#find "${BUILD_PROJECT_DIR}" -name 'PROJECT_NAME.*' -type f -print0 | xargs -0 echo
#find "${BUILD_PROJECT_DIR}" -name 'PROJECT_NAME.*' -type f -exec bash -c 'mv "$1" "${1/PROJECT_NAME/$PROJECT_NAME}"' -- {} \;


find "${BUILD_PROJECT_DIR}" -name 'PROJECT_NAME.*' -type f | while read line; do
 echo "${line}"
 mv "$line" "${line/PROJECT_NAME/$PROJECT_NAME}"
done

yarn --cwd "${BUILD_PROJECT_DIR}" install
yarn --cwd "${BUILD_PROJECT_DIR}" build
yarn --cwd "${BUILD_PROJECT_DIR}" test
yarn --cwd "${BUILD_PROJECT_DIR}" clean:full

