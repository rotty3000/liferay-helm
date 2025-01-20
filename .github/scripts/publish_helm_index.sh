#!/usr/bin/env bash
set -ev

tmpDir=$(mktemp -d)
pushd $tmpDir >& /dev/null

git clone ${REPO_URL}
cd ${REPOSITORY}
git checkout ${PUBLISH_BRANCH}

# Index the helm build chart and merge the index with the published one
helm repo index ${CHARTS_TMP_DIR} --url ${CHARTS_URL} --merge "${INDEX_DIR}/index.yaml"

# Copy the updated index over the previously published one
mv -f ${CHARTS_TMP_DIR}/index.yaml ${INDEX_DIR}/index.yaml

# Rewrite the urls into the correct OCI format
yq -i '.entries.liferay[].urls[] |= sub("-(\d+\.\d+\.\d+)\.tgz", ":$1")' ${INDEX_DIR}/index.yaml

# Copy the markdown files to the gh-pages branch
find ${SOURCE_DIR} -name "*.md" -exec cp -f '{}' . \;

# Diff for observability
echo "=== Start of Diff ==="
git diff
echo "=== End of Diff ==="

# Commits need to be signed so we use the gh cli to ensure the changes are signed by `github-actions[bot]`
CHANGED=($(git diff --name-only | xargs))

for value in "${CHANGED[@]}"
do
  FILES="${FILES} -F files[][path]=\"$value\" -F files[][contents]=$(base64 -w0 $value)"
done

gh api graphql \
	-F \$githubRepository=${GIT_REPOSITORY} \
	-F branchName=${PUBLISH_BRANCH} \
	-F expectedHeadOid=$(git rev-parse HEAD) \
	-F commitMessage="publish: new helm index release" \
	-F "query=@.github/api/createCommitOnBranch.gql" \
	${FILES}

popd >& /dev/null
rm -rf $tmpDir
