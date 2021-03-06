import os.path
import atexit

# tab complete
try:
    import readline
except ImportError:
    print("Module readline not available.")
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

# history file
history_path = os.path.expanduser("~/.pdb_history")

# import previous history if available
if os.path.exists(history_path):
    readline.read_history_file(history_path)

# save history file on REPL exit
def save_history():
    import readline, os.path
    history_path = os.path.expanduser("~/.pdb_history")
    readline.write_history_file(history_path)

atexit.register(save_history)

del atexit, os, save_history, readline, rlcompleter, history_path
