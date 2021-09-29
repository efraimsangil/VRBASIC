@Init:
_SPEED(3)
' Inicializamos el modo grafico con GL
_GLINIT
' Indicamos como queremos la vista
' El argumento 2 = SCALE TO SCREEN RESOLUTION
_GLSCREEN(340, 250, 2)
' Aplicamos un color de fondo
_GLCALL(0, "setbgcolor", _GLCOLOR(255,255,0,0))
' Creamos un escenario
st = _GLNEW(0, "stage1", "gl_stage")
_GLCALL(st, "setactive")
_GLCALL(st, "setmain")
' Creamos un sprite en el escenario que sera nuestro background
s1 = _GLNEW(st, "bg", "gl_sprite")
' Agregamos un grafico al sprite
_GLCALL(s1, "addframe", "graphics/Trojan-Stage1.png")

GOSUB @PlayerInit
_GLNEW(st,"music01","gl_music")
_GLCALL("music01","load","audio/03_Stage_1.mp3")
' _GLCALL("music01","play")

_GLCALL(0, "play")

' MAIN GAME LOOP
@MainGameLoop:
GOSUB @PlayerUpdate
GOSUB @CameraUpdate
goto @MainGameLoop

' CAMERA
@CameraUpdate:
IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 100 THEN _GLCALL(st,"inccamerapos",1,0)
RETURN

' PLAYER
@PlayerInit:
s2 = _GLNEW(st, "player", "gl_sprite")
_GLCALL(s2, "addanimationwithsheet", "quiet", "graphics/Walking.png", 0,0,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Walking.png", 0,3,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "levantar", "graphics/Walking.png", 0,0,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "attack", "graphics/Attack1.png", 0,2,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "down", "graphics/Down.png", 0,0,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "attackdown", "graphics/AttackDown.png", 0,1,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Jump.png", 0,2,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "setpos", 10, 180)
DX=0:DY=0: ' controlamos la velocidad en la direccion
M$="quiet"
GOSUB @PlayerChangeState
RETURN

@PlayerUpdate:
S=STICK(0)
IF (DX<>0) THEN _GLCALL(s2,"SetHFlip",(DX<0))
IF (M$="quiet") THEN GOSUB @PlayerQuiet
IF (M$="walk") THEN GOSUB @PlayerWalk
IF (M$="down") THEN GOSUB @PlayerDown
IF (M$="jump") THEN GOSUB @PlayerJump
IF DX<0 AND (_GLCALL(s2,"getXF") - _GLCALL(st,"getcamerax"))<10 THEN DX=0
_GLCALL(s2,"incpos",DX,DY)
RETURN

@PlayerChangeState:
IF (M$="quiet") THEN _GLCALL(s2, "setanimation", "quiet"):DX=0:DY=0
IF (M$="walk") THEN _GLCALL(s2, "setanimation", "andar")
IF (M$="down") THEN _GLCALL(s2, "setanimation", "down"):DX=0:DY=0
IF (M$="jump") THEN _GLCALL(s2, "setanimation", "jump"):DY=-10
RETURN

@PlayerWaitForEndAnimation:
IF _GLCALL(s2, "GetAnimationLoops") < 1 THEN goto @PlayerWaitForEndAnimation
RETURN

@PlayerQuiet:
IF (S=3) THEN DX=2:M$="walk":GOSUB @PlayerChangeState
IF (S=7) THEN DX=-2:M$="walk":GOSUB @PlayerChangeState
IF (S=5) THEN M$="down":GOSUB @PlayerChangeState
IF (S=1) THEN M$="jump":GOSUB @PlayerChangeState
IF (S=2) THEN M$="jump":DX=2:GOSUB @PlayerChangeState
IF (S=8) THEN M$="jump":DX=-2:GOSUB @PlayerChangeState
RETURN

@PlayerWalk:
IF (S<>3 AND S<>7) THEN M$="quiet":GOSUB @PlayerChangeState
IF (S=3) THEN DX=2
IF (S=7) THEN DX=-2
IF (S=5) THEN M$="down":GOSUB @PlayerChangeState
IF (S=1) THEN M$="jump":GOSUB @PlayerChangeState
IF (S=2) THEN M$="jump":DX=2:GOSUB @PlayerChangeState
IF (S=8) THEN M$="jump":DX=-2:GOSUB @PlayerChangeState
RETURN

@PlayerDown:
IF (S<>5) THEN M$="quiet":GOSUB @PlayerChangeState
RETURN

@PlayerJump:
DY=DY+1
IF _GLCALL(s2,"getY")>180 THEN _GLCALL(s2,"setY", 180):M$="quiet":GOSUB @PlayerChangeState
IF (S=3) THEN DX=2
IF (S=7) THEN DX=-2
RETURN

@PlayerJumpAttack:
RETURN

@PlayerQuietAttack:
RETURN

@PlayerWalkAttack:
RETURN
