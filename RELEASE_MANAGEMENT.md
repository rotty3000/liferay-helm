## Release Management

To build and release a new version of this chart create a tag in the form `vX.Y.Z` in the main branch of the repository.

```shell
git tag vX.Y.Z
git push --tags
```

A github action workflow will trigger the creation of and publishing of a release using the tag as the version.
