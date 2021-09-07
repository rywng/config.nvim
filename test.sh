#!/bin/sh

cd ~/.config/
mv nvim nvim.bak
mv nvim.new nvim
mv /home/juan/.local/share/nvim/site/pack /home/juan/.local/share/nvim/site/pack.bak
mv /home/juan/.local/share/nvim/site/pack.new /home/juan/.local/share/nvim/site/pack
# nvim
# mv nvim nvim.new
# mv nvim.bak nvim
# mv /home/juan/.local/share/nvim/site/pack /home/juan/.local/share/nvim/site/pack.new
# mv /home/juan/.local/share/nvim/site/pack.bak /home/juan/.local/share/nvim/site/pack
