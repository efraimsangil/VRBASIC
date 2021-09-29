@Init:
    _SPEED(3)
    COLOR 15,1,1
    _GLOFF
    ' Inicializamos el modo grafico con GL
    _GLINIT
    GOSUB @SetupScreen
    GOSUB @PlayerInit
    GOSUB @LoadMusicFX
    _GLCALL(0, "play")
    _GLON
    GOSUB @ThomasWalk
    GOSUB @RobocopWalk
    GOSUB @ThomasFight
    END

@SetupScreen:
    ' Indicamos como queremos la vista
    ' El argumento 2 = SCALE TO SCREEN RESOLUTION
    _GLSCREEN(340, 250, 2)
    ' Aplicamos un color de fondo
    _GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))
    ' Creamos un escenario
    st = _GLNEW(0, "stage1", "gl_stage")
    _GLCALL(st, "setactive")
    _GLCALL(st, "setmain")
    RETURN

' PLAYER
@PlayerInit:
    ' Creamos un sprite en el escenario que sera nuestro background
    s1 = _GLNEW(st, "bg", "gl_sprite")
    ' Agregamos un grafico al sprite
    _GLCALL(s1, "addframe", "graphics/kungfumaster-arc_floor2.png")
    s2 = _GLNEW(st, "player", "gl_sprite")
    _GLCALL(s2, "addanimationwithsheet", "quiet", "graphics/Thomas_punch-Sheet.png", 0,0,0,0,55,75, -1, -1, -1)
    _GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Thomas_walk-Sheet.png", 0,3,0,0,55,75, -1, -1, -1)
    _GLCALL(s2, "addanimationwithsheet", "punch", "graphics/Thomas_punch-Sheet.png", 0,3,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "addanimationwithsheet", "down", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Thomas_jump_kick-Sheet.png", 0,4,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "addanimationwithsheet", "dead", "graphics/Thomas_dead-Sheet.png", 0,15,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "setpos", 10, 90)

    s3 = _GLNEW(st, "player2", "gl_sprite")
    _GLCALL(s3, "SetScale", 1.2)
    _GLCALL(s3, "addanimationwithsheet", "robocopWalk", "graphics/Robocop.png", 0,7,0,0,64,60, -1, -1, -1)
    _GLCALL(s3, "addanimationwithsheet", "robocopQuiet", "graphics/Robocop.png", 0,0,0,0,64,60, -1, -1, -1)
    _GLCALL(s3, "addanimationwithsheet", "robocopShooting", "graphics/Robocop_Shooting.png", 0,3,0,0,64,60, -1, -1, -2)
    _GLCALL(s3, "SetHFlip", 1)
    _GLCALL(s3, "setpos", 500, 90)

    DX=0 ' controlamos la velocidad en la direccion
    _GLCALL(s2, "setanimation", "quiet"):DX=0

    frases=_GLNEW(st,"hud","gl_text")
    _GLCALL(frases,"SetFontName","computer_pixel-7.ttf")
    _GLCALL(frases,"SetFontSize","18")
    _GLCALL(frases,"SetText","Ya voy yo a mirar de donde sale ese ruido!")
    _GLCALL(frases, "setpos", 50, 200)
    RETURN

@LoadMusicFX:
    _GLNEW(st,"music01","gl_music")
    _GLCALL("music01","load","audio/02 Main BGM.ogg")
    _GLCALL("music01","play")

    _GLNEW(st,"sound01","gl_sound")
    _GLCALL("sound01","load","audio/shoot.ogg")

    _GLNEW(st,"sound02","gl_sound")
    _GLCALL("sound02","load","audio/Robocop_01.ogg")

    _GLNEW(st,"sound03","gl_sound")
    _GLCALL("sound03","load","audio/Punch.ogg")

    _GLNEW(st,"sound04","gl_sound")
    _GLCALL("sound04","load","audio/Jump.ogg")

    _GLNEW(st,"sound05","gl_sound")
    _GLCALL("sound05","load","audio/Down.ogg")
    RETURN

' CAMERA
    @CameraUpdate:
    IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 150 THEN _GLCALL(st,"inccamerapos",2,0)
    RETURN

@ThomasWalk:
    FOR T=0 TO 140
        DX=2
        _GLCALL(s2,"incpos",DX,0)
        FOR K=1 to 15: NEXT K : REM Espera
        _GLCALL(s2, "setanimation", "andar")
        gosub @CameraUpdate
    NEXT T
    _GLCALL(s2, "setanimation", "quiet")
    DX=0
    _GLCALL(frases,"SetText","Algo se acerca...")
    _GLCALL(frases, "setpos", 170, 200)

    gosub @ThomasCabeza
    RETURN

@ThomasCabeza:
    FOR T=1 TO 2
        _GLCALL(s2, "SetHFlip", 0)
        FOR K=1 to 400: NEXT K : REM Espera
        _GLCALL(s2, "SetHFlip", 1)
        FOR K=1 to 400: NEXT K : REM Espera
        _GLCALL(s2, "SetHFlip", 0)
        FOR K=1 to 400: NEXT K : REM Espera
    NEXT T
    RETURN

@RobocopWalk:
    _GLCALL("sound02","play")

    _GLCALL(frases,"SetText","WTF!")
    _GLCALL(frases, "setpos", 180, 200)

    FOR T=0 TO 65
        DX=-2
        _GLCALL(s3,"incpos",DX,0)
        FOR K=1 to 20: NEXT K : REM Espera
        _GLCALL(s3, "setanimation", "robocopWalk")
    NEXT T
    _GLCALL(s3, "setanimation", "robocopQuiet")
    DX=0
    RETURN

@ThomasFight:
    _GLCALL(frases,"SetText","Como te acerques te reviento!")
    _GLCALL(frases, "setpos", 170, 200)
    FOR T=1 TO 2
        _GLCALL("sound03","play")
        _GLCALL(s2, "setanimation", "punch")
        FOR K=1 to 400: NEXT K : REM Espera
        _GLCALL("sound04","play")
        _GLCALL(s2, "setanimation", "jump")
        FOR K=1 to 400: NEXT K : REM Espera
        _GLCALL("sound05","play")
        _GLCALL(s2, "setanimation", "down")
        FOR K=1 to 400: NEXT K : REM Espera
    NEXT T
    _GLCALL(frases,"SetText","Vamos!! Ven aquí!")
    _GLCALL(frases, "setpos", 170, 200)
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "setanimation", "quiet")
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s3, "SetHFlip", 0)
    _GLCALL("sound01","play")
    _GLCALL(s3, "setanimation", "robocopShooting")
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "setanimation", "dead")
    FOR K=1 to 1500: NEXT K : REM Espera

    RETURN