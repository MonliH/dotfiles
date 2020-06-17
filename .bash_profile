export PATH=/System/Volumes/Data/Applications/Postgres.app/Contents/Versions/12/bin/:$PATH
# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
PATH="/usr/local/Cellar/rakudo/2020.02.1/share/perl6/site/bin:${PATH}"
export PATH

export PATH="/Users/jonathanli/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH=$PATH:/opt/apache-maven-3.6.3/bin
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/bin
export PATH="/usr/local/sbin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

export SDKROOT=$(xcrun --sdk macosx --show-sdk-path)
export PATH="$PATH:/usr/local/Cellar/mongodb-community@4.0/4.0.18/bin"
