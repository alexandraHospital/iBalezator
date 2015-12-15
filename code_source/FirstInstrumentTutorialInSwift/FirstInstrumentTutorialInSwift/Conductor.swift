//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

class Conductor {

    var toneGenerator = ToneGenerator()
    var fx: EffectsProcessor
    let e2Freq : Float = 82.41
    var curNote = ToneGeneratorNote()
    
    init() {
        AKOrchestra.addInstrument(toneGenerator)
        self.fx = EffectsProcessor(audioSource: toneGenerator.auxilliaryOutput)
        AKOrchestra.addInstrument(fx)
        AKOrchestra.start()

        self.fx.play()
    }

    func play(f: Float) {
        self.curNote.frequency.value = f
        self.toneGenerator.playNote(curNote)
    }

    func release() {
        self.curNote.stop()
    }

    func setReverbFeedbackLevel(feedbackLevel: Float) {
        self.fx.feedbackLevel.value = feedbackLevel
    }
    func setToneColor(toneColor: Float) {
        self.toneGenerator.toneColor.value = toneColor
    }
    
    func playNote(note : Note){
        var nbSem : Int = Note(frette: 0, corde: 6).semiTonesBetween(note)
        var mult = pow(2, Float(Float(nbSem) / Float(12)))

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.play(self.e2Freq *  mult)
            sleep(1)
            self.release()
        });
    }
}
