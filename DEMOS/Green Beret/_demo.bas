@Init:
_SPEED(3)
COLOR 15,1,1

_GLOFF

' Inicializamos el modo grafico con GL
_GLINIT
' Indicamos como queremos la vista
' El argumento 2 = SCALE TO SCREEN RESOLUTION
_GLSCREEN(340, 192, 2)
' Aplicamos un color de fondo
_GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))
' Creamos un escenario
st = _GLNEW(0, "stage1", "gl_stage")
_GLCALL(st, "setactive")
_GLCALL(st, "setmain")
' Creamos un sprite en el escenario que sera nuestro background
bg0 = _GLNEW(st, "bg", "gl_sprite")
_GLCALL(bg0, "setpriority", 1)
_GLCALL(bg0, "addframe", "graphics/GreenBeret-Stage1-MissileBase.png")
_GLCALL(bg0, "setalpha", 0)

s9 = _GLNEW(st, "fadeout", "gl_sprite")
_GLCALL(s9, "addemptyframe", 2900, 200);
_GLCALL(s9, "setpriority", 2)
_GLCALL(s9, "setalpha", 0)
_GLCALL(s9, "setclipping", 0)
_GLCALL(s9, "setcolor", _GLCOLOR(0,0,0,0))

GOSUB @PlayerInit
' _GLNEW(st,"music01","gl_music")
' _GLCALL("music01","load","audio/02 Main BGM.ogg")
' _GLCALL("music01","play")

' _GLNEW(st,"sound01","gl_sound")
' _GLCALL("sound01","load","audio/shoot.ogg")

' _GLNEW(st,"sound02","gl_sound")
' _GLCALL("sound02","load","audio/Robocop_01.ogg")

' _GLNEW(st,"sound03","gl_sound")
' _GLCALL("sound03","load","audio/Punch.ogg")

' _GLNEW(st,"sound04","gl_sound")
' _GLCALL("sound04","load","audio/Jump.ogg")

' _GLNEW(st,"sound05","gl_sound")
' _GLCALL("sound05","load","audio/Down.ogg")

speed=2 'Camera speed
_GLCALL(0, "play")
_GLON

' MAIN GAME LOOP
' @MainGameLoop:

gosub @GreenBeretWalk
' gosub @CameraUpdate
gosub @Enemy
GOSUB @ThomasFight
END
' IF FIGHT=0 THEN gosub @ThomasFight
' goto @MainGameLoop

' CAMERA
@CameraUpdate:
IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 150 THEN _GLCALL(st,"inccamerapos",speed,0)
RETURN

' PLAYER
@PlayerInit:
s2 = _GLNEW(st, "player", "gl_sprite")
_GLCALL(s2, "setpriority", 3)
_GLCALL(s2, "addanimationwithsheet", "quiet", "graphics/Sprite_01_Sheet.png", 0,0,0,0,32,32, -1, -1, -1)
_GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Sprite_01_Sheet.png", 0,5,0,0,32,32, -1, -1, -1)
' _GLCALL(s2, "addanimationwithsheet", "punch", "graphics/Thomas_punch-Sheet.png", 0,3,0,0,55,75, -1, -1, -2)
' _GLCALL(s2, "addanimationwithsheet", "down", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -2)
' _GLCALL(s2, "addanimationwithsheet", "attackdown", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -1)
' _GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Thomas_jump_kick-Sheet.png", 0,4,0,0,55,75, -1, -1, -2)
' _GLCALL(s2, "addanimationwithsheet", "dead", "graphics/Thomas_dead-Sheet.png", 0,15,0,0,55,75, -1, -1, -2)
_GLCALL(s2, "setpos", 10, 152)

s3 = _GLNEW(st, "player2", "gl_sprite")
_GLCALL(s2, "setpriority", 3)
' _GLCALL(s3, "SetScale", 1.2)
_GLCALL(s3, "addanimationwithsheet", "enemy1Walk", "graphics/Sprite_02_Sheet.png", 0,5,0,0,32,32, -1, -1, -1)
_GLCALL(s3, "addanimationwithsheet", "enemy1Quiet", "graphics/Sprite_02_Sheet.png", 0,0,0,0,32,32, -1, -1, -1)
' _GLCALL(s3, "addanimationwithsheet", "robocopShooting", "graphics/Robocop_Shooting.png", 0,3,0,0,64,60, -1, -1, -2)
_GLCALL(s3, "SetHFlip", 1)
_GLCALL(s3, "setpos", 520, 152)

DX=0:DY=0:DZ=0 ' controlamos la velocidad en la direccion
HEAD=1:FIGHT=1
ESPERA=1500

_GLCALL(s2, "setanimation", "quiet"):DX=0:DY=0

' frases=_GLNEW(st,"hud","gl_text")
' _GLCALL(frases,"SetFontBitmapProperties", 8, 8, 32)
' _GLCALL(frases,"SetFontName","font_msx_8x8.tga")
' _GLCALL(frases,"SetFontBitmapProperties", numCharsInWidth, numCharsInHeight, charStart)
' _GLCALL(frases,"SetFontSize","12")
' _GLCALL(frases,"SetText","PROBANDO GREEN BERET PARA MSXVR")
' _GLCALL(frases, "setpos", 10, 200)

frases=_GLNEW(st,"hud","gl_text")
' _GLCALL(frases,"SetFontBitmapProperties", 32, 8, 0)
' _GLCALL(frases,"SetFontName","font_msx_8x8.tga")
_GLCALL(frases,"SetFontName","bold_pw.ttf")
_GLCALL(frases,"SetFontSize","12")
_GLCALL(frases,"SetText","PROBANDO GREEN BERET PARA MSXVR")
_GLCALL(frases, "setpos", 50, 50)
_GLCALL(frases, "setpriority", 2)
_GLCALL(frases, "setclipping", 0)
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))

RETURN

@GreenBeretWalk:
FOR K=1 to 256
    _GLCALL(bg0, "setalpha", A)
    IF A<255 THEN A=A+1
NEXT K
FOR T=0 TO 160
    DX=2
    _GLCALL(s2,"incpos",DX,0)
    FOR K=1 to 25: NEXT K : ' Espera
    _GLCALL(s2, "setanimation", "andar")
    speed=2.2:gosub @CameraUpdate
NEXT T
_GLCALL(s2, "setanimation", "quiet")
DX=0
DY=0
_GLCALL(frases,"SetText","Escucho algo...")
_GLCALL(frases, "setpos", 50, 50)
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))


gosub @GreenBeretHead
RETURN

@GreenBeretHead:
FOR T=1 TO 2
    _GLCALL(s2, "SetHFlip", 0)
    FOR K=1 to 400: NEXT K : ' Espera
    _GLCALL(s2, "SetHFlip", 1)
    FOR K=1 to 400: NEXT K : ' Espera
    _GLCALL(s2, "SetHFlip", 0)
    FOR K=1 to 400: NEXT K : ' Espera
NEXT T
RETURN

@Enemy:
_GLCALL("sound02","play")
_GLCALL(frases,"SetText","Y tu que quieres?")
_GLCALL(frases, "setpos", 50, 50)

FOR T=0 TO 65
    DX=-2
    _GLCALL(s3,"incpos",DX,0)
    FOR K=1 to 20: NEXT K : ' Espera
    _GLCALL(s3, "setanimation", "enemy1Walk")
NEXT T
_GLCALL(s3, "setanimation", "enemy1Quiet")
DX=0
RETURN

@ThomasFight:
_GLCALL(frases,"SetText","Me manda Alberto.")
_GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
_GLCALL(frases, "setpos", 50, 50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","Que ocurre?")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
_GLCALL(frases,"SetText","Hay que decirle a Efraim que vuelva")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases,"SetText","a trabajar con el Monkey Island.")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","De eso nada, ahora toca Green Beret")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
_GLCALL(frases,"SetText","Habla con Efraim y dile que pare esto.")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","Que no! Estamos probando el scroll.")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
_GLCALL(frases,"SetText","Vale... Esto se va a poner feo.")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
_GLCALL(frases,"SetText","")
_GLCALL(frases, "setpos", 50,50)
FOR T=0 TO 150
    DX=-2
    _GLCALL(s3,"incpos",DX,0)
    FOR K=1 to 20: NEXT K : ' Espera
    _GLCALL(s3, "setanimation", "enemy1Walk")
NEXT T
_GLCALL(s3, "setanimation", "enemy1Quiet")
DX=0
FOR K=1 to ESPERA-500: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","Que habra querido decir con eso?")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","Pasoooooooooo ligero! Ar!")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera

FOR T=0 TO 350
    DX=3    'Si ponemos un 3, el sprite corre más que la camara y se sale de la pantalla.
    _GLCALL(s2,"incpos",DX,0)
    FOR K=1 to 10: NEXT K : ' Espera
    _GLCALL(s2, "setanimation", "andar")
    speed=3:gosub @CameraUpdate
NEXT T
'Sonido de truenos
_GLCALL(s2, "setanimation", "quiet")
FOR K=1 to ESPERA: NEXT K : ' Espera

'Fade Out to negro
'Tyrael
'Fade In 
FOR K=0 TO 255
    _GLCALL(s9, "setalpha", K) ' Fade Out
NEXT K

FOR K=1 to ESPERA: NEXT K : ' Espera
_GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
_GLCALL(frases,"SetText","Y ahora? Que ha pasado?")
_GLCALL(frases, "setpos", 50,50)
FOR K=1 to ESPERA: NEXT K : ' Espera
DX=0
DY=0


RETURN