echo """
*.rbc
capybara-*.html
.rspec
/storage
/log
/tmp
/db/*.sqlite3
/public/system
/coverage/
/spec/tmp
*.orig
rerun.txt
pickle-email-*.html

# Environment normalization:
/.bundle
/vendor/bundle

# Ignore node_modules
/node_modules

# Ignore precompiled assets
/public/assets

# Ignore master key for decrypting credentials
/config/master.key

# Ignore local environment files
.env
.env.*
""" > .gitignore