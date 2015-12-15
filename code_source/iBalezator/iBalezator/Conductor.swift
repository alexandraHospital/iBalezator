//
//  Conductor.swift
//  SwiftKeyboard
//
//  Created by Aurelius Prochazka on 11/28/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

class Conductor {
    let e3Freq : Float = 164.8
    var instrument = AKInstrument()
    init() {}
    
    func getFrequency(note: Note) -> Float {
        var nbSem : Int = Note(frette: 0, corde: 6).semiTonesBetween(note)
        var mult = pow(2, Float(Float(nbSem) / Float(12)))
        return self.e3Freq * mult
    }
    
    func playNote(note : Note)
    {
        instrument.stop()
        instrument = AKInstrument()
        let f = AKOscillator();
        f.frequency = AKInstrumentProperty(value: self.getFrequency(note), minimum: self.e3Freq, maximum: 2000)
        instrument.setAudioOutput(f)
        AKOrchestra.addInstrument(instrument)
        let dur : NSTimeInterval = 1.0
        instrument.playForDuration(dur)
    }
}
