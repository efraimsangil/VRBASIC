@Init:
' DEMO Monkey Island

_SPEED(3)
COLOR 15,1,1
_GLOFF
'To control the language
' lang$="es"
' lang = _GLCALL(0, "getlanguage")
' if lang$ = "es" THEN

' Inicializamos el modo grafico con GL
_GLINIT
' Indicamos como queremos la vista
' El argumento 2 = SCALE TO SCREEN RESOLUTION
' El argumento 4 = 
_GLSCREEN(300, 200, 4)
' Aplicamos un color de fondo
_GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))

' Creamos un escenario
st = _GLNEW(0, "stage1", "gl_stage")
_GLCALL(st, "setactive")
_GLCALL(st, "setmain")
_GLCALL(st, "setpriority", 0)

' Creamos un escenario para el HUD
hud = _GLNEW(0, "hud", "gl_stage")
_GLCALL(hud, "setglobal", 1)
_GLCALL(hud, "setpriority", 1)

'Action panel
'Dar
dar = _GLNEW(hud, "dar", "gl_text")
_GLCALL(dar,"SetFontName","ONESIZE.ttf")
_GLCALL(dar,"SetFontSize","11")
_GLCALL(dar,"SetText","Dar")
_GLCALL(dar, "setpos", 20, 150)
_GLCALL(dar, "setclipping", 0)
_GLCALL(dar, "setcolor", _GLCOLOR(172,0,172))

'Abrir
abrir = _GLNEW(hud, "abrir", "gl_text")
_GLCALL(abrir,"SetFontName","ONESIZE.ttf")
_GLCALL(abrir,"SetFontSize","11")
_GLCALL(abrir,"SetText","Abrir")
_GLCALL(abrir, "setpos", 20, 161)
_GLCALL(abrir, "setclipping", 0)
_GLCALL(abrir, "setcolor", _GLCOLOR(172,0,172))

'Cerrar
ce = _GLNEW(hud, "cerrar", "gl_text")
_GLCALL(ce,"SetFontName","ONESIZE.ttf")
_GLCALL(ce,"SetFontSize","11")
_GLCALL(ce,"SetText","Cerrar")
_GLCALL(ce, "setpos", 20, 172)
_GLCALL(ce, "setclipping", 0)
_GLCALL(ce, "setcolor", _GLCOLOR(172,0,172))

' Tirar
tirar = _GLNEW(hud, "tirar", "gl_text")
_GLCALL(tirar,"SetFontName","ONESIZE.ttf")
_GLCALL(tirar,"SetFontSize","11")
_GLCALL(tirar,"SetText","Tirar")
_GLCALL(tirar, "setpos", 70, 150)
_GLCALL(tirar, "setclipping", 0)
_GLCALL(tirar, "setcolor", _GLCOLOR(172,0,172))

' Empujar
emp = _GLNEW(hud, "empujar", "gl_text")
_GLCALL(emp,"SetFontName","ONESIZE.ttf")
_GLCALL(emp,"SetFontSize","11")
_GLCALL(emp,"SetText","Empujar")
_GLCALL(emp, "setpos", 70, 161)
_GLCALL(emp, "setclipping", 0)
_GLCALL(emp, "setcolor", _GLCOLOR(172,0,172))

' Hablar a
hab = _GLNEW(hud, "hablar", "gl_text")
_GLCALL(hab,"SetFontName","ONESIZE.ttf")
_GLCALL(hab,"SetFontSize","11")
_GLCALL(hab,"SetText","Hablar")
_GLCALL(hab, "setpos", 70, 172)
_GLCALL(hab, "setclipping", 0)
_GLCALL(hab, "setcolor", _GLCOLOR(172,0,172))

' Usar
usar = _GLNEW(hud, "usar", "gl_text")
_GLCALL(usar,"SetFontName","ONESIZE.ttf")
_GLCALL(usar,"SetFontSize","11")
_GLCALL(usar,"SetText","Usar")
_GLCALL(usar, "setpos", 130, 150)
_GLCALL(usar, "setclipping", 0)
_GLCALL(usar, "setcolor", _GLCOLOR(172,0,172))

' Coger
coger = _GLNEW(hud, "coger", "gl_text")
_GLCALL(coger,"SetFontName","ONESIZE.ttf")
_GLCALL(coger,"SetFontSize","11")
_GLCALL(coger,"SetText","Coger")
_GLCALL(coger, "setpos", 130, 161)
_GLCALL(coger, "setclipping", 0)
_GLCALL(coger, "setcolor", _GLCOLOR(172,0,172))

' Mirar
mirar = _GLNEW(hud, "mirar", "gl_text")
_GLCALL(mirar,"SetFontName","ONESIZE.ttf")
_GLCALL(mirar,"SetFontSize","11")
_GLCALL(mirar,"SetText","Mirar")
_GLCALL(mirar, "setpos", 130, 172)
_GLCALL(mirar, "setclipping", 0)
_GLCALL(mirar, "setcolor", _GLCOLOR(172,0,172))

'Sprite de Guy
guy = _GLNEW(st, "guy", "gl_sprite")
_GLCALL(guy, "setvisible", 0)
_GLCALL(guy, "addanimationwithsheet", "walkdown", "graphics/Guy_Walking_Down-Sheet.png", 0,5,0,0,50,50, -1, -1, -1,0.2)
_GLCALL(guy, "addanimationwithsheet", "walkup", "graphics/Guy_Walking_Up-Sheet.png", 0,5,0,0,50,50, -1, -1, -1,0.2)
_GLCALL(guy, "addanimationwithsheet", "quiet", "graphics/Guy_Walking_Down-Sheet.png", 0,0,0,0,50,50, -1, -1, -1)
_GLCALL(guy, "addanimationwithsheet", "walkrightleft", "graphics/Guy_Walking_RightLeft-Sheet.png", 0,5,0,0,50,50, -1, -1, -1,0.2)
_GLCALL(guy, "setpriority", 2)
_GLCALL(guy, "SetScale", 0.2)
_GLCALL(guy, "setpos", 10, 65)

'Pointer del juego (cruz para hacer mover al protagonista)
po = _GLNEW(hud, "pointer", "gl_sprite")
_GLCALL(po, "setvisible", 0)
_GLCALL(po, "setpriority", 100)
' Agregamos un grafico al sprite
_GLCALL(po, "addframe", "graphics/pointer.png")

' gosub @IntroData

_GLCALL(0, "play")
_GLON

'Everything start here

' gosub @Logo
gosub @Stage1

' MAIN GAME LOOP
@MainGameLoop:
GOSUB @PlayerUpdate
' GOSUB @CameraUpdate
goto @MainGameLoop
END

@CameraUpdate:
' CX = _GLCALL(guy, "getx") - 150
' CY = _GLCALL(guy, "gety") - 100
' IF CX < 0 CX = 0
' IF CY < 0 CY = 0
' _GLCALL(st,"setcamerax",CX)
' _GLCALL(st,"setcameray",CY)

IF (_GLCALL(guy,"GetX")-_GLCALL(st,"getcameraX")) > 160 THEN _GLCALL(st,"inccamerapos",3,0)
IF (_GLCALL(guy,"GetX")-_GLCALL(st,"getcameraX")) < 100 THEN _GLCALL(st,"inccamerapos",-3,0)
RETURN

@PlayerUpdate:
    'Pointer movement
    _GLCALL(po, "setvisible", 1)
    S=STICK(1)
    _GLCALL(po, "setpos", _GLCALL(0, "getcursorX"), _GLCALL(0, "getcursorY"))

    'Click something with pointer
    IF STRIG(1) THEN DX = _GLCALL(st, "getcamerax") + _GLCALL(0, "getcursorx"):DY=_GLCALL(0,"getcursory"):GOSUB @GUYTO
    RETURN

@GUYTO:
    GX = _GLCALL(guy, "getX") 'Posicion actual de Guy (eje X)
    GY = _GLCALL(guy, "getY") 'Posicion actual de Guy (eje Y)
    IF (ABS(GX - DX) < 10) THEN SX = 0 ELSE SX = SGN(DX-GX) 'Si vamos hacia delante, SX=0. Si vamos atrás es -1
    IF (ABS(GY - DY) < 10) THEN SY = 0 ELSE SY = SGN(DY-GY) 'Si vamos hacia abajo, SY=0. Si vamos arriba es -1

    ' ScaleY = 0.1 + GY * 0.25
    ' IF ScaleY > 1 THEN ScaleY = 1

    W = _GLCALL(guy, "getWF")
    H = _GLCALL(guy, "getHF")-5
    C = _GLRED(_GLCALL(bgcol, "getFramePixel", 0, GX+W/2+SX, GY+H+SY))
    IF (C == 255) THEN GOTO @GUYTO_OK
    C = _GLRED(_GLCALL(bgcol, "getFramePixel", 0, GX+W/2+SX, GY+H))
    IF (C == 255) THEN SY = 0 : GOTO @GUYTO_OK
    C = _GLRED(_GLCALL(bgcol, "getFramePixel", 0, GX+W/2, GY+H+SY))
    IF (C == 255) THEN SX = 0

@GUYTO_OK:
    _GLCALL(guy, "sethflip", (SX < 0)) 'Si el eje X es negativo es que vamos atrás y giramos el sprite
    IF (SX = 0 AND SY = 0) THEN _GLCALL(guy, "setanimation", "quiet") : RETURN
    IF SX = 0 AND SY > 0 THEN _GLCALL(guy, "setanimation", "walkdown")
    IF SX = 0 AND SY < 0 THEN _GLCALL(guy, "setanimation", "walkup")
    IF SX <> 0 AND SY = 0 THEN _GLCALL(guy, "setanimation", "walkrightleft") 
    ' _GLCALL(guy,"SetAnimationSpeedFactor",2)
    ' _GLCALL(guy, "SetScale", ScaleY)
    _GLCALL(guy, "incpos", SX*2, SY*2)
    gosub @CameraUpdate
    GOTO @GUYTO

@Stage1:
'Muestra el Stage1 con efecto Fade IN
bg0 = _GLNEW(st, "bg0", "gl_sprite")
_GLCALL(bg0, "setpriority", 1)
' Agregamos un grafico al sprite
_GLCALL(bg0, "addframe", "graphics/29.png")
_GLCALL(bg0, "setalpha", 0)

bg1 = _GLNEW(st, "bg0", "gl_sprite")
_GLCALL(bg1, "setpriority", 3)
' Agregamos un grafico al sprite
_GLCALL(bg1, "addframe", "graphics/29_fg.png")
_GLCALL(bg1, "setalpha", 0)

bgcol = _GLNEW(st, "bgcol", "gl_sprite")
_GLCALL(bgcol, "setvisible", 0) : ' esto es para que se vea, lo normal es que esté quitado en modo normal y puesto en modo debug
_GLCALL(bgcol, "setflags", 4)
_GLCALL(bgcol, "addframe", "graphics/29_collision.png")
_GLCALL(bgcol, "setflags", 0)
_GLCALL(bgcol, "setpriority", 100) : ' esto es para que se vea la colisión superpuesta por encima de todo
' _GLCALL(bgcol, "setalpha", 200) : ' esto es para verlo super puesto y visualizar mejor la colision

'Fade In 
FOR K=1 to 256
    _GLCALL(bg0, "setalpha", A)
    _GLCALL(bg1, "setalpha", A)
    IF A<255 THEN A=A+1
NEXT K : REM Espera

'Guy andando solo al entrar en Stage 1
_GLCALL(guy, "setvisible", 1)

scale=0.2
FOR T=0 TO 10
    DX=1
    _GLCALL(guy,"incpos",DX,0)
    FOR K=1 to 25: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkrightleft")
NEXT T
FOR T=0 TO 8
    DY=1
    _GLCALL(guy,"incpos",0,DY)
    FOR K=1 to 25: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkdown")
    _GLCALL(guy, "SetScale", scale)
    scale=scale+0.01
NEXT T
FOR T=0 TO 10
    DX=1
    _GLCALL(guy,"incpos",DX,0)
    FOR K=1 to 25: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkrightleft")
    _GLCALL(guy, "SetScale", scale)
    scale=scale+0.01
NEXT T
FOR T=0 TO 20
    DY=1
    _GLCALL(guy,"incpos",0,DY)
    FOR K=1 to 25: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkdown")
    _GLCALL(guy, "SetScale", scale)
    scale=scale+0.01
NEXT T
FOR T=0 TO 18
    DX=2
    _GLCALL(guy,"incpos",DX,0)
    FOR K=1 to 15: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkrightleft")
    _GLCALL(guy, "SetScale", scale)
    scale=scale+0.01
NEXT T
FOR T=0 TO 120
    DX=2
    _GLCALL(guy,"SetAnimationSpeedFactor",2)
    _GLCALL(guy,"incpos",DX,0)
    FOR K=1 to 10: NEXT K : REM Espera
    _GLCALL(guy, "setanimation", "walkrightleft")
    gosub @CameraUpdate
    
NEXT T

_GLCALL(guy, "setanimation", "quiet")
DX=0

'Coloco el POINTER
_GLCALL(po, "setpos", 100, 65)
' _TTSTALK("Hola me llamo Efraim")

RETURN

@IntroData:
' Creamos un sprite en el escenario que sera nuestro background
bg0 = _GLNEW(st, "bg0", "gl_sprite")
_GLCALL(bg0, "setpriority", 0)
' Agregamos un grafico al sprite
_GLCALL(bg0, "addframe", "graphics/BG0.png")
_GLCALL(bg0, "setalpha", 0)

' Creamos un sprite en el escenario que sera nuestro background
bg1 = _GLNEW(st, "bg1", "gl_sprite")
_GLCALL(bg1, "setpriority", 1)
' Agregamos un grafico al sprite
_GLCALL(bg1, "addframe", "graphics/BG1.png")
_GLCALL(bg1, "setalpha", 0)

' Creamos un sprite en el escenario que sera nuestro background
bg2 = _GLNEW(st, "bg2", "gl_sprite")
_GLCALL(bg2, "setpriority", 2)
' Agregamos un grafico al sprite
_GLCALL(bg2, "addframe", "graphics/BG2.png")
_GLCALL(bg2, "setalpha", 0)

fg1 = _GLNEW(st, "fg1", "gl_sprite")
_GLCALL(fg1, "setpriority", 3)
' Agregamos un grafico al sprite
_GLCALL(fg1, "addframe", "graphics/Letters.png")
_GLCALL(fg1, "setalpha", 0)

logo = _GLNEW(st, "logo", "gl_sprite")
_GLCALL(logo, "setpriority", 2)

_GLNEW(st,"music01","gl_music")
_GLCALL("music01","load","audio/Track17.ogg")
RETURN

'Logotipo de Lucas
@Logo:
_GLOFF
_GLCALL(bg0, "setvisible", "false")
_GLCALL(bg1, "setvisible", "false")
_GLCALL(bg2, "setvisible", "false")
_GLCALL(fg1, "setvisible", "false")
_GLON
FOR K=1 to 500: NEXT K : REM Espera
_GLCALL("music01","play")
FOR K=1 to 1000: NEXT K : REM Espera
_GLCALL(logo, "AddAnimationWithPrefix", "quiet", "graphics/logo%02d.png", 1, 39, -1, -1, -1, 0.25)
_GLCALL(logo, "setanimation", "quiet")
FOR K=1 to 9400: NEXT K : REM Espera
_GLCALL(logo, "setvisible", "false")
_GLCALL(bg0, "setvisible", "true")
_GLCALL(bg1, "setvisible", "true")
_GLCALL(bg2, "setvisible", "true")
A=0
FOR K=1 to 300
    _GLCALL(bg0, "setalpha", A) ' Fade Out
    _GLCALL(bg1, "setalpha", A) ' Fade Out
    _GLCALL(bg2, "setalpha", A) ' Fade Out
    IF A<255 THEN A=A+1
NEXT K : REM Espera
A=0
_GLCALL(fg1, "setvisible", "true")
FOR T=0 TO 1500       
    DX=-0.1
    _GLCALL(bg1,"incpos",DX,0)
    ' FOR K=1 to 20: NEXT K : REM Espera
    _GLCALL(fg1, "setalpha", A): ' Fade Out
    IF A<255 THEN A=A+1
    
        ' frases=_GLNEW(st,"hud","gl_text"):
        ' _GLCALL(frases, "setpriority", 2):
        ' _GLCALL(frases,"SetFontName","ONESIZE.ttf"):
        ' _GLCALL(frases,"SetFontSize","14"):
        ' _GLCALL(frases,"SetText","Una aventura para el MSXVR"):
        ' _GLCALL(frases, "setpos", 50, 180)
NEXT T
_GLCALL(fg1, "setvisible", "true")

DX=0
' DY=0
FOR K=1 to 3000: NEXT K : REM Espera
RETURN