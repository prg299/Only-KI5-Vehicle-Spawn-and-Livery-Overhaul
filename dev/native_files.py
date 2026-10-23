"""Read a command receipt without blocking Windows atomic replacement."""
import ctypes,json,msvcrt,os
from ctypes import wintypes as W

kernel=ctypes.WinDLL('kernel32',use_last_error=True)
kernel.CreateFileW.argtypes=[W.LPCWSTR,W.DWORD,W.DWORD,ctypes.c_void_p,W.DWORD,W.DWORD,W.HANDLE]
kernel.CreateFileW.restype=W.HANDLE

def read_json(path):
    handle=kernel.CreateFileW(str(path),0x80000000,7,None,3,0x80,None)
    if handle==W.HANDLE(-1).value:raise ctypes.WinError(ctypes.get_last_error())
    descriptor=msvcrt.open_osfhandle(handle,os.O_RDONLY)
    with os.fdopen(descriptor,'r',encoding='utf-8-sig') as stream:return json.load(stream)
