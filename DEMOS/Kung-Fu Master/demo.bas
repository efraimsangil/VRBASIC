@Init:
_SPEED(3)
COLOR 15,1,1
_GLOFF

' Inicializamos el modo grafico con GL
_GLINIT
' Indicamos como queremos la vista
' El argumento 2 = SCALE TO SCREEN RESOLUTION
_GLSCREEN(340, 250, 2)
' Aplicamos un color de fondo
_GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))
' Creamos un escenario
st = _GLNEW(0, "stage1", "gl_stage")
_GLCALL(st, "setactive")
_GLCALL(st, "setmain")
' Creamos un sprite en el escenario que sera nuestro background
s1 = _GLNEW(st, "bg", "gl_sprite")
' Agregamos un grafico al sprite
_GLCALL(s1, "addframe", "graphics/kungfumaster-arc_floor2.png")

GOSUB @PlayerInit
_GLNEW(st,"music01","gl_music")
_GLCALL("music01","load","audio/02 Main BGM.ogg")
_GLCALL("music01","play")

_GLCALL(0, "play")
_GLON

' MAIN GAME LOOP
@MainGameLoop:

gosub @ThomasWalk
gosub @CameraUpdate
IF HEAD=0 THEN gosub @RobocopWalk
goto @MainGameLoop

' CAMERA
@CameraUpdate:
IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 150 THEN _GLCALL(st,"inccamerapos",2,0)
RETURN

' PLAYER
@PlayerInit:
s2 = _GLNEW(st, "player", "gl_sprite")
_GLCALL(s2, "addanimationwithsheet", "quiet", "graphics/Thomas_punch-Sheet.png", 0,0,0,0,55,75, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Thomas_walk-Sheet.png", 0,3,0,0,55,75, -1, -1, -1)
'_GLCALL(s2, "addanimationwithsheet", "levantar", "graphics/Thomas_punch-Sheet.png", 0,0,0,0,55,75, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "down", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -2)
' _GLCALL(s2, "addanimationwithsheet", "attackdown", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Thomas_jump_kick-Sheet.png", 0,4,0,0,55,75, -1, -1, -2)
_GLCALL(s2, "setpos", 10, 90)

s3 = _GLNEW(st, "player2", "gl_sprite")
_GLCALL(s3, "addanimationwithsheet", "robocopWalk", "graphics/Robocop.png", 0,7,0,0,64,60, -1, -1, -1)
_GLCALL(s3, "addanimationwithsheet", "robocopQuiet", "graphics/Robocop.png", 0,0,0,0,64,60, -1, -1, -1)
_GLCALL(s3, "SetHFlip", 1)
_GLCALL(s3, "setpos", 500, 105)

DX=0:DY=0:DZ=0 ' controlamos la velocidad en la direccion
HEAD=1:FIGHT=1
_GLCALL(s2, "setanimation", "quiet"):DX=0:DY=0
RETURN

@ThomasWalk:
IF _GLCALL(s2,"getX")<190 THEN:
    _GLCALL(s2,"incpos",DX,0):
    _GLCALL(s2, "setanimation", "andar"):
    DX=2
IF _GLCALL(s2,"getX")>=190 THEN:
    _GLCALL(s2, "setanimation", "quiet"):
    DX=0:
    DY=0:
    IF HEAD=1 THEN goto @ThomasCabeza
RETURN

@ThomasCabeza:
FOR T=1 TO 2
    _GLCALL(s2, "SetHFlip", 0)
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "SetHFlip", 1)
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "SetHFlip", 0)
    FOR K=1 to 500: NEXT K : REM Espera
NEXT T
HEAD=0

@RobocopWalk:
IF _GLCALL(s3,"getX")>300 THEN:
    _GLCALL(s3,"incpos",DZ,0):
    _GLCALL(s3, "setanimation", "robocopWalk"):
    DZ=-2
IF _GLCALL(s3,"getX")<=300 THEN:
    _GLCALL(s3, "setanimation", "robocopQuiet"):
    DZ=0:
    IF FIGHT=1 THEN goto @ThomasFight
RETURN

@ThomasFight:
FOR T=1 TO 5
    _GLCALL(s2, "setanimation", "down")
NEXT T
FOR T=1 TO 5
    _GLCALL(s2, "setanimation", "jump")
NEXT T