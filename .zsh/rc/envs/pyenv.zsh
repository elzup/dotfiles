
# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# caffe
export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/cuda/lib:$HOME/.pyenv/versions/anaconda-2.0.1/lib:/usr/local/lib:/usr/lib

