"""Query Workshop details and add requirements with the owner Steam client.

Adapted from Real Vehicle Interiors MIT developer tooling. See LICENSE/CREDITS.
The caller configures ITEM and DEPENDENCIES after reconciling saved item IDs.
"""
import ctypes as C
import os,time
from pathlib import Path
APP, OWNER = 108600, int(os.environ.get('ONLY_KI5_STEAM_OWNER','76561198042483215'))
ITEM = None
DEPENDENCIES = {}
P, U64, U32, BOOL = C.c_void_p, C.c_uint64, C.c_uint32, C.c_bool


class QueryResult(C.Structure):
    _fields_ = [('handle', U64), ('result', C.c_int), ('returned', U32),
                ('total', U32), ('cached', BOOL), ('cursor', C.c_char * 256)]


class UpdateResult(C.Structure):
    _fields_ = [('result', C.c_int), ('agreement', BOOL), ('item', U64)]


class DependencyResult(C.Structure):
    _fields_ = [('result', C.c_int), ('parent', U64), ('child', U64)]


class ItemDetails(C.Structure):
    # Valve's documented SteamUGCDetails_t layout and string limits, Windows x64
    # alignment. Reserve trailing space for newer SDK fields we do not inspect.
    # https://partner.steamgames.com/doc/api/ISteamUGC#SteamUGCDetails_t
    # https://partner.steamgames.com/doc/api/ISteamRemoteStorage#Constants
    _fields_ = [
        ('item', U64), ('result', C.c_int), ('file_type', C.c_int),
        ('creator_app', U32), ('consumer_app', U32),
        ('title', C.c_char * 129), ('description', C.c_char * 8000),
        ('owner', U64), ('created', U32), ('updated', U32), ('added', U32),
        ('visibility', C.c_int), ('banned', BOOL), ('accepted', BOOL),
        ('tags_truncated', BOOL), ('tags', C.c_char * 1025),
        ('file', U64), ('preview_file', U64), ('filename', C.c_char * 260),
        ('file_size', C.c_int32), ('preview_size', C.c_int32),
        ('url', C.c_char * 256), ('votes_up', U32), ('votes_down', U32),
        ('score', C.c_float), ('children', U32), ('reserved', C.c_char * 256),
    ]


class Steam:
    def __init__(self):
        os.environ['SteamAppId'] = str(APP)
        os.environ['SteamGameId'] = str(APP)
        self.api = C.CDLL(str(Path(os.environ.get('PZ_GAME_DIR',r'C:\SteamLibrary\steamapps\common\ProjectZomboid'))/'steam_api64.dll'))
        self.bind('SteamAPI_InitFlat', C.c_int, P)
        self.bind('SteamAPI_Shutdown', None)
        self.bind('SteamAPI_RunCallbacks', None)
        self.bind('SteamAPI_SteamUGC_v021', P)
        self.bind('SteamAPI_SteamUtils_v010', P)
        self.bind('SteamAPI_SteamUser_v023', P)
        self.bind('SteamAPI_ISteamUser_GetSteamID', U64, P)
        self.bind('SteamAPI_ISteamUser_BLoggedOn', BOOL, P)
        self.bind('SteamAPI_ISteamUtils_IsAPICallCompleted', BOOL, P, U64, C.POINTER(BOOL))
        self.bind('SteamAPI_ISteamUtils_GetAPICallResult', BOOL, P, U64, P, C.c_int, C.c_int, C.POINTER(BOOL))
        self.bind('SteamAPI_ISteamUGC_CreateQueryUGCDetailsRequest', U64, P, C.POINTER(U64), U32)
        self.bind('SteamAPI_ISteamUGC_SetReturnAdditionalPreviews', BOOL, P, U64, BOOL)
        self.bind('SteamAPI_ISteamUGC_SetReturnChildren', BOOL, P, U64, BOOL)
        self.bind('SteamAPI_ISteamUGC_SetReturnLongDescription', BOOL, P, U64, BOOL)
        self.bind('SteamAPI_ISteamUGC_SetAllowCachedResponse', BOOL, P, U64, U32)
        self.bind('SteamAPI_ISteamUGC_SendQueryUGCRequest', U64, P, U64)
        self.bind('SteamAPI_ISteamUGC_GetQueryUGCResult', BOOL, P, U64, U32, P)
        self.bind('SteamAPI_ISteamUGC_GetQueryUGCChildren', BOOL, P, U64, U32, C.POINTER(U64), U32)
        self.bind('SteamAPI_ISteamUGC_GetQueryUGCNumAdditionalPreviews', U32, P, U64, U32)
        self.bind('SteamAPI_ISteamUGC_GetQueryUGCAdditionalPreview', BOOL, P, U64, U32, U32,
                  P, U32, P, U32, C.POINTER(C.c_int))
        self.bind('SteamAPI_ISteamUGC_GetQueryUGCPreviewURL', BOOL, P, U64, U32, P, U32)
        self.bind('SteamAPI_ISteamUGC_ReleaseQueryUGCRequest', BOOL, P, U64)
        self.bind('SteamAPI_ISteamUGC_StartItemUpdate', U64, P, U32, U64)
        self.bind('SteamAPI_ISteamUGC_SetItemDescription', BOOL, P, U64, C.c_char_p)
        self.bind('SteamAPI_ISteamUGC_SetItemVisibility', BOOL, P, U64, C.c_int)
        self.bind('SteamAPI_ISteamUGC_AddItemPreviewFile', BOOL, P, U64, C.c_char_p, C.c_int)
        self.bind('SteamAPI_ISteamUGC_UpdateItemPreviewFile', BOOL, P, U64, U32, C.c_char_p)
        self.bind('SteamAPI_ISteamUGC_SubmitItemUpdate', U64, P, U64, C.c_char_p)
        self.bind('SteamAPI_ISteamUGC_AddDependency', U64, P, U64, U64)
        self.bind('SteamAPI_ISteamUGC_RemoveDependency', U64, P, U64, U64)
        self.bind('SteamAPI_ISteamUGC_RemoveItemPreview', BOOL, P, U64, U32)
        error = C.create_string_buffer(1024)
        if self.api.SteamAPI_InitFlat(error) != 0:
            raise RuntimeError('Steam API initialization failed: ' + error.value.decode(errors='replace'))
        self.ugc, self.utils = self.api.SteamAPI_SteamUGC_v021(), self.api.SteamAPI_SteamUtils_v010()
        user = self.api.SteamAPI_SteamUser_v023()
        if self.api.SteamAPI_ISteamUser_GetSteamID(user) != OWNER:
            self.api.SteamAPI_Shutdown()
            raise RuntimeError('Signed-in Steam account does not own this Workshop item')
        if not self.api.SteamAPI_ISteamUser_BLoggedOn(user):
            self.api.SteamAPI_Shutdown()
            raise RuntimeError(
                'Steam desktop is disconnected. Reconnect the owner account in Steam, '
                'then rerun this gallery upload after SteamCMD has finished. '
                'SteamCMD login can replace the desktop session.')

    def bind(self, name, result, *args):
        fn = getattr(self.api, name)
        fn.restype, fn.argtypes = result, list(args)

    def call(self, handle, structure, callback, timeout=180):
        if not handle:
            raise RuntimeError('Invalid asynchronous Steam call')
        deadline = time.monotonic() + timeout
        failed = BOOL()
        while not self.api.SteamAPI_ISteamUtils_IsAPICallCompleted(self.utils, handle, C.byref(failed)):
            if time.monotonic() > deadline:
                raise TimeoutError('Steam call outcome unknown; query before retrying')
            self.api.SteamAPI_RunCallbacks()
            time.sleep(.1)
        value = structure()
        if failed.value or not self.api.SteamAPI_ISteamUtils_GetAPICallResult(
                self.utils, handle, C.byref(value), C.sizeof(value), callback, C.byref(failed)) or failed.value:
            raise RuntimeError('Steam callback retrieval failed')
        if value.result != 1:
            raise RuntimeError(f'Steam operation failed, EResult={value.result}')
        return value

    def query(self):
        ids = (U64 * 1)(ITEM)
        handle = self.api.SteamAPI_ISteamUGC_CreateQueryUGCDetailsRequest(self.ugc, ids, 1)
        if not handle or handle == 2**64 - 1:
            raise RuntimeError('Invalid Steam query')
        try:
            if not self.api.SteamAPI_ISteamUGC_SetReturnAdditionalPreviews(self.ugc, handle, True):
                raise RuntimeError('Additional-preview query rejected')
            if not self.api.SteamAPI_ISteamUGC_SetReturnChildren(self.ugc, handle, True):
                raise RuntimeError('Dependency query rejected')
            if not self.api.SteamAPI_ISteamUGC_SetReturnLongDescription(self.ugc, handle, True):
                raise RuntimeError('Description query rejected')
            if not self.api.SteamAPI_ISteamUGC_SetAllowCachedResponse(self.ugc, handle, 0):
                raise RuntimeError('Fresh query rejected')
            result = self.call(self.api.SteamAPI_ISteamUGC_SendQueryUGCRequest(self.ugc, handle), QueryResult, 3401)
            if result.returned != 1:
                raise RuntimeError('Workshop item missing from query')
            details = ItemDetails()
            if not self.api.SteamAPI_ISteamUGC_GetQueryUGCResult(self.ugc, handle, 0, C.byref(details)):
                raise RuntimeError('Workshop details query failed')
            if details.item != ITEM or details.result != 1 or details.consumer_app != APP or details.owner != OWNER:
                raise RuntimeError('Workshop identity or details layout could not be verified; refusing mutations')
            if details.children > 4096:
                raise RuntimeError('Unexpected dependency count; refusing a truncated query')
            children = (U64 * details.children)()
            if details.children and not self.api.SteamAPI_ISteamUGC_GetQueryUGCChildren(
                    self.ugc, handle, 0, children, details.children):
                raise RuntimeError('Workshop dependency query failed')
            main = C.create_string_buffer(4096)
            self.api.SteamAPI_ISteamUGC_GetQueryUGCPreviewURL(self.ugc, handle, 0, main, len(main))
            previews = []
            count = self.api.SteamAPI_ISteamUGC_GetQueryUGCNumAdditionalPreviews(self.ugc, handle, 0)
            for index in range(count):
                url, name, kind = C.create_string_buffer(4096), C.create_string_buffer(1024), C.c_int()
                if not self.api.SteamAPI_ISteamUGC_GetQueryUGCAdditionalPreview(
                        self.ugc, handle, 0, index, url, len(url), name, len(name), C.byref(kind)):
                    raise RuntimeError('Preview query failed')
                previews.append(dict(index=index, name=name.value.decode(), url=url.value.decode(), type=kind.value))
            return dict(workshopId=ITEM, title=details.title.decode('utf-8', errors='replace'),
                        description=details.description.decode('utf-8', errors='replace'),
                        visibility=details.visibility, cover=main.value.decode(), previews=previews,
                        dependencies=list(children), missingDependencies=[d for d in DEPENDENCIES if d not in children])
        finally:
            self.api.SteamAPI_ISteamUGC_ReleaseQueryUGCRequest(self.ugc, handle)

    def add_dependencies(self, existing, completed):
        # AddDependency is its own committed operation, not a SubmitItemUpdate
        # setting. Query before each addition so retries after an unknown outcome
        # cannot blindly add the same relationship. Never remove other children.
        present = set(existing['dependencies'])
        for child in DEPENDENCIES:
            if child in present:
                continue
            fresh = self.query()
            present.update(fresh['dependencies'])
            if child in present:
                continue
            completed(dict(operation='addDependency', workshopId=child, name=DEPENDENCIES[child], status='submitting'))
            result = self.call(self.api.SteamAPI_ISteamUGC_AddDependency(self.ugc, ITEM, child),
                               DependencyResult, 3412)
            if result.parent != ITEM or result.child != child:
                raise RuntimeError('Dependency callback identity mismatch; query before retrying')
            present.add(child)
            completed(dict(operation='addDependency', workshopId=child, name=DEPENDENCIES[child], status='complete', result=result.result))

    def remove_dependencies(self, existing, allowed, completed):
        """Remove only the owner-authorized vehicle requirements, idempotently."""
        unwanted=set(existing['dependencies'])-set(DEPENDENCIES)
        if unwanted-set(allowed):
            raise ValueError('Unexpected requirements; refusing to remove unknown items')
        for child in sorted(unwanted):
            fresh=self.query()
            if child not in fresh['dependencies']:
                continue
            completed(dict(operation='removeDependency',workshopId=child,status='submitting'))
            result=self.call(self.api.SteamAPI_ISteamUGC_RemoveDependency(self.ugc,ITEM,child),DependencyResult,3413)
            if result.parent!=ITEM or result.child!=child:
                raise RuntimeError('Removal callback identity mismatch; query before retrying')
            completed(dict(operation='removeDependency',workshopId=child,status='complete',result=result.result))

    def upload_page(self, files, existing, description=None, replace_gallery=False):
        """RVI's preview updater, restricted to this already-unlisted item.

        Does not set content, main cover, title, tags or visibility. Query before
        retrying after an unknown SubmitItemUpdate outcome.
        """
        if existing['workshopId'] != ITEM or existing['visibility'] != 3:
            raise ValueError('Page update requires the verified unlisted item')
        handle = self.api.SteamAPI_ISteamUGC_StartItemUpdate(self.ugc, APP, ITEM)
        if not handle or handle == 2**64 - 1:
            raise RuntimeError('Invalid item update')
        if description is not None and not self.api.SteamAPI_ISteamUGC_SetItemDescription(
                self.ugc, handle, description.encode('utf-8')):
            raise RuntimeError('Steam rejected description')
        indexes = {p['name']: p['index'] for p in existing['previews']}
        if replace_gallery:
            for index in sorted(indexes.values(),reverse=True):
                if not self.api.SteamAPI_ISteamUGC_RemoveItemPreview(self.ugc,handle,index):
                    raise RuntimeError('Steam rejected removal of old gallery preview')
            indexes={}
        for path in files:
            encoded = str(path).encode('utf-8')
            if path.name in indexes:
                ok = self.api.SteamAPI_ISteamUGC_UpdateItemPreviewFile(self.ugc, handle, indexes[path.name], encoded)
            else:
                ok = self.api.SteamAPI_ISteamUGC_AddItemPreviewFile(self.ugc, handle, encoded, 0)
            if not ok:
                raise RuntimeError('Steam rejected gallery image '+path.name)
        result = self.call(self.api.SteamAPI_ISteamUGC_SubmitItemUpdate(self.ugc, handle, None), UpdateResult, 3404)
        if result.item != ITEM:
            raise RuntimeError('Update callback item mismatch; query before retrying')
        if result.agreement:
            raise RuntimeError('Owner must accept the Steam Workshop agreement')
        return result.result

    def cloud_quota(self):
        """Read app preview staging capacity without changing any Cloud files."""
        self.bind('SteamAPI_SteamRemoteStorage_v016', P)
        self.bind('SteamAPI_ISteamRemoteStorage_GetQuota', BOOL, P, C.POINTER(U64), C.POINTER(U64))
        total, available = U64(), U64()
        storage = self.api.SteamAPI_SteamRemoteStorage_v016()
        if not storage or not self.api.SteamAPI_ISteamRemoteStorage_GetQuota(
                storage, C.byref(total), C.byref(available)):
            raise RuntimeError('Steam Cloud quota query failed')
        return dict(totalBytes=total.value, availableBytes=available.value)
