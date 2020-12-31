######## FIND PERL BACKDOORS ###########

find / -type f -exec grep -l -E '#!\/usr\/bin\/perl' '{}' \; | xargs -d '\n' grep -l -E 'bind\(.+\)'

find / -type f -exec grep -l -E '#!\/usr\/bin\/python' '{}' \; | xargs -d '\n' grep -l -E 'bind\(.+\)'