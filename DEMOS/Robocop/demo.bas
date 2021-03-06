@Init:
    _SPEED(3)
    COLOR 15,1,1
    _GLOFF
    _GLINIT
    _GLSCREEN(340, 230, 4)
    _GLCALL(0, "setbgcolor", _GLCOLOR(255,0,0,0))
    st = _GLNEW(0, "stage1", "gl_stage")
    _GLCALL(st, "setactive")
    _GLCALL(st, "setmain")
    s1 = _GLNEW(st, "bg", "gl_sprite")
    _GLCALL(s1, "addframe", "graphics/RoboCop-Stage1.png")
    s9 = _GLNEW(st, "fadeout", "gl_sprite")
    _GLCALL(s9, "addemptyframe", 1000, 1000)
    _GLCALL(s9, "setpriority", 2)
    _GLCALL(s9, "setalpha", 0)
    _GLCALL(s9, "setclipping", 0)
    _GLCALL(s9, "setcolor", _GLCOLOR(0,0,0,0))
    GOSUB @PlayerInit
    _GLNEW(st,"music01","gl_music")
    _GLCALL("music01","load","audio/Apatrullando La Ciudad_01.ogg")
    _GLCALL("music01","play")
    _GLNEW(st,"sound01","gl_sound")
    _GLCALL("sound01","load","audio/transformers-7_01.ogg")
    _GLNEW(st,"sound02","gl_sound")
    _GLCALL("sound02","load","audio/whistle-campana-whatsapp.ogg")
    _GLNEW(st,"sound03","gl_sound")
    _GLCALL("sound03","load","audio/Punch.ogg")
    _GLNEW(st,"sound04","gl_sound")
    _GLCALL("sound04","load","audio/Jump.ogg")
    _GLNEW(st,"sound05","gl_sound")
    _GLCALL("sound05","load","audio/Down.ogg")
    _GLNEW(st,"sound06","gl_sound")
    _GLCALL("sound06","load","audio/AlienAttack.ogg")
    _GLCALL(0, "play")
    _GLON
    gosub @RobocopWalk
    gosub @ThomasWalk
    GOSUB @ThomasFight
    gosub @AlienWalk
    END

@CameraUpdate:
    IF (_GLCALL(s2,"GetX")-_GLCALL(st,"getcameraX")) > 150 THEN _GLCALL(st,"inccamerapos",2,0)
    RETURN

@PlayerInit:
    s2 = _GLNEW(st, "Thomas", "gl_sprite")
    _GLCALL(s2, "setpriority", 1)
    _GLCALL(s2, "addanimationwithsheet", "quiet", "graphics/Thomas_punch-Sheet.png", 0,0,0,0,55,75, -1, -1, -1)
    _GLCALL(s2, "addanimationwithsheet", "andar", "graphics/Thomas_walk-Sheet.png", 0,3,0,0,55,75, -1, -1, -1)
    _GLCALL(s2, "addanimationwithsheet", "punch", "graphics/Thomas_punch-Sheet.png", 0,3,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "addanimationwithsheet", "down", "graphics/Thomas_low_kick-Sheet.png", 0,5,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "addanimationwithsheet", "jump", "graphics/Thomas_jump_kick-Sheet.png", 0,4,0,0,55,75, -1, -1, -2)
    _GLCALL(s2, "SetHFlip", 1)
    _GLCALL(s2, "setpos", 500, 160)
    s3 = _GLNEW(st, "Robocop", "gl_sprite")
    _GLCALL(s3, "setpriority", 1)
    _GLCALL(s3, "SetScale", 1.2)
    _GLCALL(s3, "addanimationwithsheet", "robocopWalk", "graphics/Robocop_Walk-Sheet.png", 0,7,0,0,55,75, -1, -1, -1)
    _GLCALL(s3, "addanimationwithsheet", "robocopQuiet", "graphics/Robocop_Walk-Sheet.png", 0,0,0,0,55,75, -1, -1, -1)
    _GLCALL(s3, "addanimationwithsheet", "robocopPower", "graphics/Robocop_Power-Sheet.png", 0,2,0,0,55,75, -1, -1, -2)
    _GLCALL(s3, "addanimationwithsheet", "robocopShooting", "graphics/Robocop_Shooting.png", 0,3,0,0,64,60, -1, -1, -2)
    _GLCALL(s3, "addanimationwithsheet", "robocopDead", "graphics/Robocop_Dead-Sheet.png", 0,12,0,0,55,75, -1, -1, -2)
    _GLCALL(s3, "setpos", 10, 155)
    s4 = _GLNEW(st, "Alien", "gl_sprite")
    _GLCALL(s4, "setpriority", 1)
    _GLCALL(s4, "addanimationwithsheet", "alienWalk", "graphics/Alien_Walk-Sheet.png", 0,6,0,0,170,100, -1, -1, -1)
    _GLCALL(s4, "addanimationwithsheet", "alienQuiet", "graphics/Alien_Punch-Sheet.png", 0,0,0,0,170,100, -1, -1, -2)
    _GLCALL(s4, "addanimationwithsheet", "alienPunch", "graphics/Alien_Punch-Sheet.png", 0,3,0,0,170,100, -1, -1, -2)
    _GLCALL(s4, "SetHFlip", 1)
    _GLCALL(s4, "setpos", 700, 135)
    DX=0:DY=0:DZ=0 
    HEAD=1:FIGHT=1
    YY=10
    _GLCALL(s2, "setanimation", "quiet"):DX=0:DY=0
    
    frases=_GLNEW(st,"hud","gl_text")
    _GLCALL(frases, "setpriority", 2)
    _GLCALL(frases,"SetFontName","computer_pixel-7.ttf")
    _GLCALL(frases,"SetFontSize","18")
    _GLCALL(frases, "setclipping", 0) 
    _GLCALL(frases,"SetText","APATRULLANDO LA CIUDAD!")
    _GLCALL(frases, "setpos", 110, 10)
    RETURN

@RobocopWalk:
    FOR T=0 TO 140
    DX=2
    _GLCALL(s3,"incpos",DX,0)
    FOR K=1 to 20: NEXT K : REM Espera
    _GLCALL(s3, "setanimation", "robocopWalk")
    gosub @CameraUpdate
    NEXT T
    _GLCALL(s3, "setanimation", "robocopQuiet")
    DX=0
    DY=0
    RETURN
    @AlienWalk:
    FOR T=0 TO 190
    DX=-2
    _GLCALL(s4,"incpos",DX,0)
    FOR K=1 to 15: NEXT K : REM Espera
    _GLCALL(s4, "setanimation", "alienWalk")
    NEXT T
    _GLCALL(s4, "setanimation", "alienQuiet")
    _GLCALL(frases,"SetText","ATACA BOBY!")
    _GLCALL(frases, "setpos", 400, YY)
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL("sound06","play")
    _GLCALL(s4, "setanimation", "alienPunch")
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL(s3, "setanimation", "robocopDead")
    FOR K=1 to 500: NEXT K : REM Espera
    FOR K=0 TO 255
    _GLCALL(s9, "setalpha", K) 
    NEXT K
    FOR K=1 to 1000: NEXT K : REM Espera
    DX=0
    RETURN

@ThomasWalk:
    
    _GLCALL(frases,"SetText","A T? TE QUER?A VER YO!")
    _GLCALL(frases, "setpos", 400, YY)
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL(frases,"SetText","EFRA ME HA TRAIDO DE VUELTA.")
    _GLCALL(frases, "setpos", 350, YY)
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL(frases,"SetText","Y AHORA NO TIENES ARMAS. TE VOY A...")
    _GLCALL(frases, "setpos", 350, YY)
    FOR T=0 TO 65
    DX=-2
    _GLCALL(s2,"incpos",DX,0)
    FOR K=1 to 15: NEXT K : REM Espera
    _GLCALL(s2, "setanimation", "andar")
    NEXT T
    _GLCALL(s2, "setanimation", "quiet")
    DX=0
    RETURN

@ThomasFight:
    _GLCALL(frases,"SetText","")
    _GLCALL(frases, "setpos", 360, YY)
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
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "setanimation", "quiet")
    _GLCALL(frases,"SetText","VAMOS!! AHORA QU??")
    _GLCALL(frases, "setpos", 400, YY)
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL("sound01","play") 
    _GLCALL(s3, "setanimation", "robocopPower")
    FOR K=1 to 400: NEXT K : REM Espera
    _GLCALL(s3, "setanimation", "robocopQuiet")
    FOR K=1 to 500: NEXT K : REM Espera
    _GLCALL(s2, "SetHFlip", 0) 
    _GLCALL("sound02","play") 
    _GLCALL(frases,"SetText","VAAAAAALE... BOBY!!! COME HERE!!")
    _GLCALL(frases, "setpos", 350, YY)
    FOR K=1 to 800: NEXT K : REM Espera
    _GLCALL(s2, "SetHFlip", 1)
    _GLCALL(frases,"SetText","")
    _GLCALL(frases, "setpos", 400, YY)
    RETURN
