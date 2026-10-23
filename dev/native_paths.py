"""Bound disposable native caches to this project or its owned local cache."""
from pathlib import Path
import os

ROOT=Path(__file__).resolve().parents[1]
PROJECT_NATIVE=(ROOT/'build/native').resolve()
LOCAL_NATIVE=(Path.home()/'AppData/Local/GameMods/OnlyKI5/Native').resolve()
NATIVE_ROOT=Path(os.environ.get('ONLY_KI5_NATIVE_ROOT',str(PROJECT_NATIVE))).resolve()
if NATIVE_ROOT not in (PROJECT_NATIVE,LOCAL_NATIVE):
    raise ValueError('Native cache root must be this project build/native or its owned local GameMods/OnlyKI5/Native cache')

def owned_run(name):
    path=(NATIVE_ROOT/name).resolve()
    # MSIX can resolve AppData to its physical package cache only after creation.
    if path.parent!=NATIVE_ROOT.resolve():
        raise ValueError('Run escaped owned native cache')
    return path
