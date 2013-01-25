#!/usr/bin/env bash

cd $(mktemp -d)
#curl -Lo- https://github.com/zielmicha/markdown-to-terminal.git | bash
git clone https://github.com/zielmicha/markdown-to-terminal.git
cd markdown-to-terminal
make
sudo cp libsoldout.so.1 /usr/lib
sudo ln -s /usr/lib/libsoldout.so.1 /usr/lib/libsoldout.so
sudo cp mkd2{man,html,term} /bin

