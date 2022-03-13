config.load_autoconfig(False)
import os.path

config.bind('d', 'scroll-page 0 0.5')
config.bind('D', 'tab-close')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('U', 'undo')

c.auto_save.session = True

