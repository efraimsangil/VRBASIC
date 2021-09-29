@Init:'
' Velocidad a la que deseamos que funcione el VRBASIC
_SPEED(3) 
COLOR 15,1,1
' Apagamos el modo gráfico GL para que mientras cargamos los sprites, fondos, etc, no se vea nada.
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
bg0 = _GLNEW(st, "bg0", "gl_sprite")
_GLCALL(bg0, "setpriority", 0)

' Agregamos un grafico al sprite
_GLCALL(bg0, "addframe", "graphics/Trojan-Stage1_BackGround.png")

' Creamos un sprite en el escenario que sera nuestro segundo background para hacer scroll parallax
bg1 = _GLNEW(st, "bg1", "gl_sprite")
_GLCALL(bg1, "setpriority", 1)

' Agregamos un grafico al sprite
_GLCALL(bg1, "addframe", "graphics/Trojan-Stage1_Cleaned.png")

' Creamos un sprite que será nuestro personaje principal
s2 = _GLNEW(st, "player", "gl_sprite")
_GLCALL(s2, "setpriority", 2)

' Definición de todas las animaciones de dicho sprite partiendo de una hoja de sprites con todos los movimientos que necesitamos
_GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Walking.png", 0,3,0,0,65,55, -1, -1, -1,0.2)
_GLCALL(s2, "addanimationwithsheet", "levantar", "graphics/Walking.png", 0,0,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "attack", "graphics/Attack1.png", 0,2,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "down", "graphics/Down.png", 0,0,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "attackdown", "graphics/AttackDown.png", 0,1,0,0,66,54, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Jump.png", 0,2,0,0,66,54, -1, -1, -2)
_GLCALL(s2, "addanimationwithsheet", "jumpattack", "graphics/JumpAttack.png", 0,1,0,0,66,54, -1, -1, -2)
'Posicionamos el sprite en pantalla
_GLCALL(s2, "setpos", 10, 180)

'Definimos la música que vamos a escuchar en esta demo
_GLNEW(st,"music01","gl_music")
_GLCALL("music01","load","audio/03_Stage_1.ogg")
_GLCALL("music01","SetVolume",90)
_GLCALL("music01","play")

'Definimos el sonido FX que suena cuando atacas con la espada
_GLNEW(st,"attack01","gl_sound")
_GLCALL("attack01","load","audio/Sword1.ogg")
_GLCALL(0, "play")

' Control del salto
' Y es el nivel de suelo
' F1 es el tope 1 de salto
' V son los pixeles que resto al eje Y para el salto
' SA es el indicador de que estamos saltando
' AT para controlar cuando ataca
Y=180:F1=130:V=10:SA=0:AT=0
'Activamos la pantalla para que todo lo definido, sea visible
_GLON

@Walking:'
IF SA=0 THEN _GLCALL(s2, "setanimation", "andar")
S=STICK(0)
IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 100 THEN:
    _GLCALL(bg0,"setx",_GLCALL(st,"getcameraX")*(-0.1)):' Movimiento lento del BG de fondo. Rascacielos.   
    _GLCALL(bg1,"setx",_GLCALL(st,"getcameraX")*(-0.3)):' Movimiento más rápido del BG de la calle
    _GLCALL(st,"inccamerapos",2,0) 'Movimiento de la camara

IF SA=1 THEN gosub @Jump
IF S=1 THEN SA=1
IF S=0 AND SA=0 THEN _GLCALL(s2,"SetAnimationSpeedFactor",0):_GLCALL(s2,"ResetAnimation")
IF S=2 THEN Y=Y-3:X=X+3
IF S=3 THEN:
	_GLCALL(s2,"SetHFlip",0):
	_GLCALL(s2,"SetAnimationSpeedFactor",1):
	_GLCALL(s2,"incpos",2,0)
IF S=4 THEN X=X+3:Y=Y+3
IF S=5 THEN @Down
IF S=6 THEN Y=Y+3:X=X-3
IF S=7 AND _GLCALL(s2,"GetX") >=10 THEN:
	_GLCALL(s2,"SetHFlip",1):
	_GLCALL(s2,"SetAnimationSpeedFactor",1):
	_GLCALL(s2,"incpos",-2,0)
IF S=8 THEN X=X-3:Y=Y-3
IF STRIG(0) AND AT=0 THEN AT=1: goto @Attack

goto @Walking

@Attack:
_GLCALL("attack01","play")
IF SA=0 AND AT=0 THEN: ' Espadazo sin salto
    AT=0:    
    _GLCALL(s2, "setanimation", "attack"):
    _GLCALL(s2,"SetAnimationSpeedFactor",1):
    GOSUB @wait_for_end_animation:
    goto @wait

IF SA=1 AND AT=1 THEN: ' Espadazo en pleno salto    
    _GLCALL(s2, "setanimation", "jumpattack"):
    _GLCALL(s2,"SetAnimationSpeedFactor",1):
    GOSUB @wait_for_end_animation:
    _GLCALL(s2, "setanimation", "jump"):
    goto @wait_jump    

@Down:'
_GLCALL(s2, "setanimation", "down")
goto @wait_down

@Jump:'
Y=Y-V
IF Y<F1 THEN V=-V
IF Y>180 THEN Y=180:SA=0:V=-V
_GLCALL(s2, "setanimation", "jump")
_GLCALL(s2,"SetAnimationSpeedFactor",1)
_GLCALL(s2, "setpos", _GLCALL(s2,"GetX"), Y)
RETURN

@wait:'
IF _GLCALL(s2, "GetAnimationLoops") >= 1 THEN:
	_GLCALL(s2, "setanimation", "andar"):
	goto @Walking
goto @wait

@wait_jump:'
IF _GLCALL(s2, "GetAnimationLoops") >= 1 THEN:
	_GLCALL(s2, "setanimation", "jump"):
goto @wait

@wait_down:'
S = STICK(0)
IF (S = 5) AND STRIG(0) THEN:
        _GLCALL("attack01","play"):
        _GLCALL(s2, "setanimation", "attackdown"):
        _GLCALL(s2,"SetAnimationSpeedFactor",1):
        GOSUB @wait_for_end_animation:
        goto @Down
IF (S = 5) THEN goto @wait_down
    _GLCALL(s2, "setanimation", "levantar")    
    GOSUB @wait_for_end_animation
    goto @Walking

@wait_for_end_animation:'
IF _GLCALL(s2, "GetAnimationLoops") < 1 THEN goto @wait_for_end_animation
RETURN
