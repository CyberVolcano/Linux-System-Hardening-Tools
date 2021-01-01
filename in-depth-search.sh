
######## FIND PYTHON BACKDOORS ###########

find / -xdev -type f -name "*.py" -exec grep -E -l "bind\(.+\)" {} \;

######## FIND PERL BACKDOORS ###########

find / -xdev -type f -name "*.pl" -exec grep -E -l "bind\(.+\)" {} \;

######## FIND COMMON PHP WEBSHELLS ###########

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo passthru\(\\$\_GET\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php echo exec\(\\$\_POST\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php system\(\\$\_GET\['cmd']); \?>" {} \;

find / -xdev -type f -name "*.php" -exec grep -E -l "<\?php passthru\(\\$\_REQUEST\['cmd']); \?>" {} \;
