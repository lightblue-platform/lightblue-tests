#!/bin/sh

YAMLs="crud/crud-find-basic-get.yaml
crud/crud-find-basic-post.yaml
crud/crud-find-complex-post.yaml
crud/crud-save.yaml
crud/crud-setup.yaml
metadata/metadata-setup.yaml
metadata/metadata-teardown.yaml"
for f in $YAMLs
do
	cat | sed 's/name\s*:\s*"\(.*\)"/&\n\1/g' | sed '/name\s*:\s*"/{n;s/\s/_/g}' | sed '/name\s*:\s*"/{n;s/\(.*\)/    - metrics: {namelookup_time, connect_time, appconnect_time, pretransfer_time, starttransfer_time, redirect_time, total_time, size_download, size_upload, request_size, speed_download, speed_upload, redirect_count, num_connects }\n    - warmup_runs: 0\n    - benchmark_runs: 1\n    - output_file: '"'"'\1-{thread}.csv'"'"'/g}'
done
