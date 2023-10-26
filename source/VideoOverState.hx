package;

import lime.app.Application;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
#if cpp
import sys.io.File;
#end

class VideoOverState extends MusicBeatSubstate
{
    public static var deadReason:DeadCause = BEING_A_LOSER;
    var shouldDoFinishCallback:Bool = true;
    var lastMessage:String = '';

    public function new(curVideo:String)
    {
        super();

        if(PlayState.isStoryMode == false)
        {
            lastMessage = 'you would like to enter the song again right?';
        }
        else
        {
            lastMessage = 'you would like to play the whole week again right?'; 
        }

        var shouldSay:String = '';

        switch(deadReason)
        {
            case BEING_A_LOSER:
                shouldSay = 'try being more fast\non touching notes';

            case SONIC_HAND:
                shouldSay = 'press space';
            
            case UNOWN:
                shouldSay = 'dont press the unowns';
        }
    }
    var manualSonic:FlxSprite = new FlxSprite().loadGraphic(Paths.image('Manual_Sonic', 'creepy'));
            manualSonic.scrollFactor.set();
            manualSonic.screenCenter();
            manualSonic.visible = false;
            add(manualSonic);

            if(PlayState.SONG.song.toLowerCase() == 'only-me')
            {
                #if desktop
                Application.current.window.alert('YOU CAN SEE?');
                Application.current.window.close();
                #end
            }

            var vhs:FlxSprite = new FlxSprite();
            vhs.frames = Paths.getSparrowAtlas('vhs_effect', 'creepy');
            vhs.animation.addByPrefix('vhs', 'VHS');
            vhs.animation.play('vhs');
            vhs.setGraphicSize(Std.int(vhs.width * 3.5));
            vhs.alpha = 0.5;
            vhs.scrollFactor.set();
            vhs.screenCenter();
            add(vhs);

            new FlxTimer().start(4, function(tmr:FlxTimer)
            {
                if(deadReason == SONIC_HAND)
                {
                    manualSonic.visible = true;
                }
            else
                textLmao.text = shouldSay;
            });
        }
    }
    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.ACCEPT)
        {
            #if desktop
            if(PlayState.SONG.song.toLowerCase() == 'only-me')
            {
                Application.current.window.alert('YOU CAN SEE?');
                Application.current.window.close();
            }
            else
            {
                Application.current.window.alert('you are very optimistic', '???');
                Application.current.window.alert('sadly', '???');
                Application.current.window.alert('if you are very optimistic', '???');
                Application.current.window.alert(lastMessage, '???');
                Application.current.window.close();
            }
            #end
            #if !desktop
            MusicBeatState.resetState();
            LoadingState.loadAndSwitchState(new PlayState(), true);
            #end
        }
        
        if (controls.BACK)
        {
            if(PlayState.SONG.song.toLowerCase() == 'only-me')
            {
                #if desktop
                Application.current.window.alert('YOU CAN SEE?');
                Application.current.window.close();
                #end
            }
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}

enum DeadCause
{
    SONIC_HAND;
    BEING_A_LOSER;
    UNOWN;
}
