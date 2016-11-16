# This file is NOT licensed under the GPLv3, which is the license for the rest
# of YouCompleteMe.
#
# Here's the license text for this file:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-Wall',
'-Wextra',
#'-Werror',
'-Wc++98-compat',
'-Wno-long-long',
'-Wno-variadic-macros',
'-fexceptions',
'-DNDEBUG',
# You 100% do NOT need -DUSE_CLANG_COMPLETER in your flags; only the YCM
# source code needs it.
'-DUSE_CLANG_COMPLETER',
# THIS IS IMPORTANT! Without a "-std=<something>" flag, clang won't know which
# language to use when compiling headers. So it will guess. Badly. So C++
# headers will be compiled as C headers. You don't want that so ALWAYS specify
# a "-std=<something>".
# For a C project, you would set this to something like 'c99' instead of
# 'c++11'.
'-std=gnu++11',
# ...and the same thing goes for the magic -x option which specifies the
# language that the files to be compiled are written in. This is mostly
# relevant for c++ headers.
# For a C project, you would set this to 'c' instead of 'c++'.
'-x',
'c++',
'-isystem',
'../BoostParts',
'-isystem',
# This path will only work on OS X, but extra paths that don't exist are not
# harmful
'/System/Library/Frameworks/Python.framework/Headers',
'-isystem',
'../llvm/include',
'-isystem',
'../llvm/tools/clang/include',
'-I',
'.',
'-I',
'./ClangCompleter',
'-isystem',
'./tests/gmock/gtest',
'-isystem',
'./tests/gmock/gtest/include',
'-isystem',
'./tests/gmock',
'-isystem',
'./tests/gmock/include',
'-I',
'Include',
'-D',
'LINUX',
'-D',
'DEF_SOFT_TOUR',
'-D',
'_REENTRANT -DLINUX -DUCLINUX -DDVR_HI',
'-D',
'APP_TOUR_TURN',
'-D',
'_FUNC_WDT_CPU',
'-D',
'_NET_USE_DHCPCLIENT',
'-D',
'USING_PROTOCOL_NTP -DUSING_PROTOCOL_NTP_OP',
'-D',
'USING_DDNS',
'-D',
'FUNCTION_NET_ALARM_CENTER',
'-D',
'FUNC_GET_HWSN',
'-D',
'FUNC_WDT',
'-D',
'VISION_DDNS ',
'-D',
'_MULTI_DDNS',
'-D',
'_FUN_DDNS_NEW',
'-D',
'LOG_APPEND_NETABORT',
'-D',
'FUNC_PREVIEW_COVER',
'-D',
'_FUN_DDNS_NEW',
'-D',
'_USE_SMTP_MODULE',
'-D',
'_FUNC_UPNP_MOUDLE',
'-D',
'FUNCTION_SUPPORT_RTSP',
'-D',
'FUNCTION_SUPPORT_RTSP_MULTICAST',
'-D',
'__NET_AUTO_SERCH_DEVICEIP',
'-D',
'NET_AUTO_REGISTER',
'-D',
'_DNS_FUNCTION=1',
'-D',
'DEF_ONLY_D1=1',
'-D',
'FTP_TRAN_SNAPSHOT=1',
'-D',
'FUNC_FTP_UPLOAD ',
'-D',
'ALM_REQUIRE_SNAP_EMAIL=1',
'-D',
'USE_SUPER_PASSWORD=\"vision\"',
'-D',
'DEF_RESOLUTION_ADJUST ',
'-D',
'FUNC_CLOUDSTORAGE',
'-D',
'RECORD_NET_THREAD_MULTI',
'-D',
'FUNC_FTP_UPLOAD ',
'-D',
'FTP_TRAN_SNAPSHOT=1',
'-D',
'_WQ_RTSP',
'-D',
'_Huanghe_RTSP',
'-D',
'_SONY_RTSP',
'-D',
'_Vivotek_RTSP',
'-D',
'_SHANGYANG_RTSP',
'-D',
'_SAMSUNG_RTSP',
'-D',
'_XWRJ_RTSP',
'-D',
'VN_IPC',
'-D',
'SYS_NO_RECORD',
'-D',
'SYS_NO_DISPLAY',
'-D',
'SYS_NO_GUI',
'-D',
'SYS_NO_BACKUP',
'-D',
'SYS_NO_PLAY',
'-D',
'SYS_NO_FRONTBOARD_FUNCTION',
'-D',
'FUNC_FRONTBOARD_CTRL		',
'-D',
'SYS_NO_MOUSE	',
'-D',
'_FUNC_ADJUST_VOLUME_	',
'-D',
'ENC_SUPPORT_SNAPSHOT',
'-D',
'FUNCTION_SUPPORT_98_UPGRADE',
'-D',
'_USE_720P_MODULE_',
'-D',
'SDK_3518',
'-D',
'_HAVE_WEB_FLASH_REGION',
'-D',
'ONVIF_SERVER',
'-D',
'ONVIF_CLIENT',
'-D',
'WITH_OPENSSL',
'-D',
'WITH_DOM',
'-D',
'UEMF',
'-D',
'WEBS',
'-D',
'ONVIF',
'-D',
'USE_ASP',
'-D',
'APP_DEBUG',
'-D',
'_FUN_RECORD_MULTISTREAM',
]


# Set this to the absolute path to the folder (NOT the file!) containing the
# compile_commands.json file to use that instead of 'flags'. See here for
# more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html
#
# You can get CMake to generate this file for you by adding:
#   set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
# to your CMakeLists.txt file.
#
# Most projects will NOT need to set this to anything; you can just change the
# 'flags' list of compilation flags. Notice that YCM itself uses that approach.
compilation_database_folder = ''

if os.path.exists( compilation_database_folder ):
  database = ycm_core.CompilationDatabase( compilation_database_folder )
else:
  database = None

SOURCE_EXTENSIONS = [ '.cpp', '.cxx', '.cc', '.c', '.m', '.mm' ]

def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in [ '.h', '.hxx', '.hpp', '.hh' ]


def GetCompilationInfoForFile( filename ):
  # The compilation_commands.json file generated by CMake does not have entries
  # for header files. So we do our best by asking the db for flags for a
  # corresponding source file, if any. If one exists, the flags for that file
  # should be good enough.
  if IsHeaderFile( filename ):
    basename = os.path.splitext( filename )[ 0 ]
    for extension in SOURCE_EXTENSIONS:
      replacement_file = basename + extension
      if os.path.exists( replacement_file ):
        compilation_info = database.GetCompilationInfoForFile(
          replacement_file )
        if compilation_info.compiler_flags_:
          return compilation_info
    return None
  return database.GetCompilationInfoForFile( filename )


def FlagsForFile( filename, **kwargs ):
  if database:
    # Bear in mind that compilation_info.compiler_flags_ does NOT return a
    # python list, but a "list-like" StringVec object
    compilation_info = GetCompilationInfoForFile( filename )
    if not compilation_info:
      return None

    final_flags = MakeRelativePathsInFlagsAbsolute(
      compilation_info.compiler_flags_,
      compilation_info.compiler_working_dir_ )

  else:
    relative_to = DirectoryOfThisScript()
    final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return { 'flags': final_flags }
