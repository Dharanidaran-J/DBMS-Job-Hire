"""
ChallengeHire - Windows Application Control / Smart App Control Compatibility Patch
====================================================================================
On Windows 11 with Smart App Control or Defender Application Control enabled,
pre-compiled C-extension DLLs (.pyd) in Python packages may be blocked with:
'ImportError: DLL load failed while importing _immutabledict_cy: An Application Control policy has blocked this file.'

SQLAlchemy provides identical official pure-Python implementations (.py) alongside
all Cython (.pyd) modules. This hook ensures Python loads the pure-Python fallbacks
seamlessly without requiring administrator privileges or registry changes.
"""

import sys
import os
import importlib.abc
import importlib.util

class WindowsPolicyFallbackFinder(importlib.abc.MetaPathFinder):
    def find_spec(self, fullname, path, target=None):
        # Intercept compiled Cython extensions in SQLAlchemy
        if 'sqlalchemy' in fullname and fullname.endswith('_cy'):
            for p in path or []:
                mod_name = fullname.split('.')[-1]
                py_path = os.path.join(p, mod_name + '.py')
                if os.path.isfile(py_path):
                    return importlib.util.spec_from_file_location(fullname, py_path)
        return None

# Install hook at the front of sys.meta_path if not already present
if not any(isinstance(finder, WindowsPolicyFallbackFinder) for finder in sys.meta_path):
    sys.meta_path.insert(0, WindowsPolicyFallbackFinder())
