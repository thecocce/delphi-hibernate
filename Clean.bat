@echo off
rem {**************************************************************************}
rem {                                                                          }
rem { Delphi Hibernate                                                         }
rem {                                                                          }
rem { Copyright (c) 2012                                                       }
rem {   Cesar Romero <cesarliws@gmail.com>                                     }
rem {   License info: read license.txt                                         }
rem {                                                                          }
rem {**************************************************************************}


:config
set F,0=*.bak
set F,1=*.dcu
set F,2=*.ddp
set F,3=*.~*
set F,4=*.local
set F,5=*.identcache
set F,6=*.tvsconfig

set D,0=__history
set D,1=Debug
set D,2=Release

set DELETE_FILE=del
set DELETE_FILE_PARAMS=/f /q /s >nul 2>&1
set DELETE_DIR=rd 
set DELETE_DIR_PARAMS=/s/q


:resourcestring
set SProcessingFiles=Cleaning files, please wait...
set SProcessingDirectories=Removing directories, please wait...
set SInputProcessDone="Type <Enter> to close..."


:begin
cls


:process_files
echo.
echo %SProcessingFiles%
echo.

for /f "usebackq delims==, tokens=1-3" %%i in (`set F`) do (
	if not "%%k"=="" (
		%DELETE_FILE% %%k %DELETE_FILE_PARAMS%
	)
)


:process_directories
echo.
echo %SProcessingDirectories%
echo.

for /f "usebackq delims==, tokens=1-3" %%i in (`set D`) do (
	if not "%%k"=="" (
		if exist %%k (
			echo "%%k"...
			%DELETE_DIR% %%k %DELETE_DIR_PARAMS%
		)
	)
)


:end
echo.
set /P USER_INPUT=%SInputProcessDone%
