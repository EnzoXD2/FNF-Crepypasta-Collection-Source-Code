package;

import lime.app.Application;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.filters.ShaderFilter;
import flixel.FlxG;
import source.shaders.*;
import flixel.text.FlxText;

class NewBuildJoke extends MusicBeatState
{
    override public function create()
    {
        super.create();

        var vcrStuff:VCRDistortionEffect = new VCRDistortionEffect();
        vcrStuff.setScanlines(false);
		vcrStuff.setPerspective(false);
		vcrStuff.setGlitchModifier(0);
		vcrStuff.setDistortion(true);
		vcrStuff.setNoise(true);
		vcrStuff.setVignette(true);

        FlxG.camera.setFilters([new ShaderFilter(vcrStuff.shader)]);

        var text1:FlxText = new FlxText(FlxG.width, FlxG.height, 0, 'enjoy the next 3 minutes', 37);
        text1.setFormat(Paths.font('vcr.ttf'), 37, FlxColor.RED, LEFT);
        text1.scrollFactor.set();
        text1.screenCenter();
        add(text1);

        new FlxTimer().start(5, function(tmr:FlxTimer)
        {
            FlxG.sound.music.stop();
            FlxG.camera.filtersEnabled = false;
            remove(text1);
            }
        });
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}
