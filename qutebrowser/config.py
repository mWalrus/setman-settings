import dracula.draw
import sys, os

sys.path.append(os.path.join(sys.path[0], 'jblock'))
config.source("jblock/jblock/integrations/qutebrowser.py")

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

config.bind('<Ctrl-l>', 'spawn --userscript qute-bitwarden')
config.bind('<Ctrl-p>', 'spawn --userscript qute-bitwarden --password-only')
