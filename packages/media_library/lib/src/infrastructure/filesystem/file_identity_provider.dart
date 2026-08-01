import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart'
    show
        CloseHandle,
        CreateFile,
        FILE_SHARE_DELETE,
        FILE_SHARE_READ,
        FILE_SHARE_WRITE,
        GENERIC_READ,
        OPEN_EXISTING;

abstract interface class FileIdentityProvider {
  Future<String?> getPlatformFileId(Uri locator);
}

/// Reads stable NTFS/ReFS identity without leaking handles or FFI types upward.
final class WindowsFileIdentityProvider implements FileIdentityProvider {
  const WindowsFileIdentityProvider();

  @override
  Future<String?> getPlatformFileId(Uri locator) async {
    if (!Platform.isWindows || locator.scheme != 'file') return null;
    final path = locator.toFilePath(windows: true);
    final nativePath = path.toNativeUtf16();
    try {
      final handle = CreateFile(
        nativePath,
        GENERIC_READ,
        FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
        nullptr,
        OPEN_EXISTING,
        0,
        0,
      );
      if (handle == -1) return null;
      try {
        final info = calloc<_FileIdInfo>();
        try {
          final getInformation = DynamicLibrary.open('kernel32.dll')
              .lookupFunction<
                Int32 Function(IntPtr, Int32, Pointer<_FileIdInfo>, Uint32),
                int Function(int, int, Pointer<_FileIdInfo>, int)
              >('GetFileInformationByHandleEx');
          if (getInformation(handle, 18, info, sizeOf<_FileIdInfo>()) == 0) {
            return null;
          }
          final serial = info.ref.volumeSerialNumber
              .toRadixString(16)
              .padLeft(16, '0');
          final identifier = [
            for (var i = 0; i < 16; i++)
              info.ref.fileId[i].toRadixString(16).padLeft(2, '0'),
          ].join();
          return 'windows:$serial:$identifier';
        } finally {
          calloc.free(info);
        }
      } finally {
        CloseHandle(handle);
      }
    } catch (_) {
      return null;
    } finally {
      calloc.free(nativePath);
    }
  }
}

final class _FileIdInfo extends Struct {
  @Uint64()
  external int volumeSerialNumber;

  @Array(16)
  external Array<Uint8> fileId;
}
