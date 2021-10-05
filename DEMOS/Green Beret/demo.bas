@Init:
    _SPEED(3)
    COLOR 15,1,1
    _GLOFF

    ' Inicializamos el modo grafico con GL
    _GLINIT
    ' Indicamos como queremos la vista
    ' El argumento 2 = SCALE TO SCREEN RESOLUTION
    _GLSCREEN(340, 192,2)
    ' Aplicamos un color de fondo
    _GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))
    ' Creamos un escenario
    st = _GLNEW(0, "stage1", "gl_stage")
    _GLCALL(st, "setactive")
    _GLCALL(st, "setmain")

    ' Creamos un escenario para el HUD
    hud = _GLNEW(0, "hud", "gl_stage")
    _GLCALL(hud, "setglobal", 1)
    _GLCALL(hud, "setpriority", 1)

    ' Creamos un sprite en el escenario que sera nuestro background
    bg0 = _GLNEW(st, "bg", "gl_sprite")
    _GLCALL(bg0, "setpriority", 1)
    _GLCALL(bg0, "addframe", "graphics/GreenBeret-Stage1-MissileBase.png")
    _GLCALL(bg0, "setalpha", 255)

    s9 = _GLNEW(st, "fadeout", "gl_sprite")
    _GLCALL(s9, "addemptyframe", 1657, 200);
    _GLCALL(s9, "setpriority", 2)
    _GLCALL(s9, "setalpha", 0)
    _GLCALL(s9, "setclipping", 0)
    _GLCALL(s9, "setcolor", _GLCOLOR(0,0,0,0))  

    GOSUB @PlayerInit

    _GLNEW(st,"music01","gl_music")
    _GLCALL("music01","load","audio/WarMusic.ogg")
    _GLCALL("music01","setVolume",100)

    _GLNEW(st,"sound01","gl_sound")
    _GLCALL("sound01","load","audio/Thunder_01.ogg")

    _GLNEW(st,"sound02","gl_sound")
    _GLCALL("sound02","load","audio/Pasos.ogg")

    speed=2 'Camera speed
    _GLCALL(0, "play")
    _GLON

    ' FOR T=1 TO 100000:NEXT T

    gosub @GreenBeretWalk
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
    _GLCALL(s3, "setpriority", 3)
    ' _GLCALL(s3, "SetScale", 1.2)
    _GLCALL(s3, "addanimationwithsheet", "enemy1Walk", "graphics/Sprite_02_Sheet.png", 0,5,0,0,32,32, -1, -1, -1)
    _GLCALL(s3, "addanimationwithsheet", "enemy1Quiet", "graphics/Sprite_02_Sheet.png", 0,0,0,0,32,32, -1, -1, -1)
    ' _GLCALL(s3, "addanimationwithsheet", "robocopShooting", "graphics/Robocop_Shooting.png", 0,3,0,0,64,60, -1, -1, -2)
    _GLCALL(s3, "SetHFlip", 1)
    _GLCALL(s3, "setpos", 520, 152)

    s4 = _GLNEW(hud, "tyrael", "gl_sprite")
    _GLCALL(s4, "setpriority", 5)
    _GLCALL(s4, "setalpha", 0)
    _GLCALL(s4, "AddAnimationWithPrefix", "quiet", "graphics/Tyrael%02d.png", 1, 15, -1, -1, -1, 0.25)
    _GLCALL(s4, "setvisible", 0)
    _GLCALL(s4, "setanimation", "quiet")

    guy = _GLNEW(st, "guy", "gl_sprite")
    _GLCALL(guy, "setpriority", 3)
    _GLCALL(guy, "setvisible", 0)
    _GLCALL(guy, "addanimationwithsheet", "walkrightleft", "graphics/Guy_Walking_RightLeft-Sheet.png", 0,5,0,0,50,50, -1, -1, -1,0.2)
    _GLCALL(guy, "SetHFlip", 1)
    _GLCALL(guy, "SetScale", 0.6)

    DX=0:DY=0:DZ=0 ' controlamos la velocidad en la direccion
    HEAD=1:FIGHT=1
    ESPERA=1700

    _GLCALL(s2, "setanimation", "quiet"):DX=0:DY=0

    frases=_GLNEW(hud,"hud","gl_text")
    ' _GLCALL(frases,"SetFontBitmapProperties", 32, 8, 0)
    ' _GLCALL(frases,"SetFontName","font_msx_8x8.tga")
    _GLCALL(frases,"SetFontName","theboldfont.ttf")
    _GLCALL(frases,"SetFontSize","12")
    _GLCALL(frases,"SetText","PROBANDO GREEN BERET PARA MSXVR")
    _GLCALL(frases, "setpos", 10, 50)
    _GLCALL(frases, "setclipping", 0)
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    RETURN

@GreenBeretWalk:
    _GLCALL("music01","play")

    FOR K=1 to 256
        _GLCALL(bg0, "setalpha", A)
        IF A<255 THEN A=A+1
    NEXT K
    ' _GLCALL(guy, "setvisible", 1)
    ' _GLCALL(guy, "setpos", 150, 108)

    FOR T=0 TO 160
        DX=2
        _GLCALL(s2,"incpos",DX,0)
        FOR K=1 to 25: NEXT K : ' Espera
        _GLCALL(s2, "setanimation", "andar")
        speed=2.2:gosub @CameraUpdate
        IF T=140 THEN _GLCALL("sound02","play") 'Sonido de pasos
    NEXT T
    'meter el sonido dentro del bucle 
    _GLCALL(s2, "setanimation", "quiet")

    DX=0
    DY=0
    _GLCALL(frases,"SetText","Escucho algo...")
    _GLCALL(frases, "setpos", 10, 50)

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
    _GLCALL(frases, "setpos", 10, 50)

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
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Que ocurre?")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
    _GLCALL(frases,"SetText","Hay que decirle a Efraim que vuelva \n a trabajar con el Monkey Island.")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA+500: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","De eso nada, ahora toca Green Beret")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
    _GLCALL(frases,"SetText","Habla con Efraim y dile que pare \neste desarrollo.")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Que no! \nEstamos probando el scroll.")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
    _GLCALL(frases,"SetText","Vaaaaale... \nEsto se va a poner feo.")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(223,113,38))
    _GLCALL(frases,"SetText","")
    _GLCALL(frases, "setpos", 10,50)
    _GLCALL("sound02","play") 'Sonido de pasos
    FOR T=0 TO 150
        DX=-2
        _GLCALL(s3,"incpos",DX,0)
        FOR K=1 to 20: NEXT K : ' Espera
        _GLCALL(s3, "setanimation", "enemy1Walk")
    NEXT T
    _GLCALL(s3, "setanimation", "enemy1Quiet")
    DX=0
    ' FOR K=1 to ESPERA-500: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Que habra querido decir con eso?")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Pasoooooooooo ligero! Ar!")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases,"SetText","")
    _GLCALL(guy, "setvisible", 1)
    _GLCALL(guy, "setpos", 700, 108)

    FOR T=0 TO 300
        DX=3    'Si ponemos un 3, el sprite corre más que la camara y se sale de la pantalla.
        _GLCALL(s2,"incpos",DX,0)
        FOR K=1 to 10: NEXT K : ' Espera
        _GLCALL(s2, "setanimation", "andar")
        speed=3:gosub @CameraUpdate
        IF T>50 THEN: 
            DA=-2:
            _GLCALL(guy,"incpos",DA,0):
            FOR K=1 to 20: NEXT K:
            _GLCALL(guy, "setanimation", "walkrightleft")
        IF T=250 THEN _GLCALL("sound01","play") 'Sonido de Trueno
            
    NEXT T

    _GLCALL(s2, "setanimation", "quiet")
    ' FOR K=1 to ESPERA: NEXT K : ' Espera

    'Fade Out to negro
    FOR K=0 TO 255
        _GLCALL(s9, "setalpha", K) ' Fade Out
    NEXT K

    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Y ahora? Que ha pasado?")
    _GLCALL(frases, "setpos", 10,50)
    FOR K=1 to ESPERA+500: NEXT K : ' Espera
    _GLCALL(frases,"SetText","")
    _GLCALL(s4, "setvisible",1)
    FOR K=1 to 256
        _GLCALL(s4, "setalpha", A)
        IF A<255 THEN A=A+1
    NEXT K
    _GLCALL(s4, "setanimation", "quiet")
    _GLCALL(s4, "setpos", 0, 0)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,0,0))
    _GLCALL(frases,"SetText","Soy Tyrael.")
    _GLCALL(frases, "setpos", 10,100)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,0,0))
    _GLCALL(frases,"SetText","Las pruebas del Green Beret \nSE ACABARON.")
    _GLCALL(frases, "setpos", 10,100)
    FOR K=1 to ESPERA: NEXT K : ' Espera
    _GLCALL(frases, "setcolor", _GLCOLOR(255,255,255))
    _GLCALL(frases,"SetText","Pues claro!\nJusto eso estaba diciendo yo.")
    _GLCALL(frases, "setpos", 10,100)
    FOR K=1 to ESPERA+1000: NEXT K : ' Espera
    DX=0
    DY=0
    RETURN