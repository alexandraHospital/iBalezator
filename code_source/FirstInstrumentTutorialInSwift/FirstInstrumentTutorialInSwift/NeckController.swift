

import UIKit
import Darwin

class NeckController {
    
    //Référence vers le contrôleur principal
    var superController : ViewController?
    var neckView : NeckView?
    
    
    /* Coordonnées des cordes avec une amplitude
    * (c'est-à-dire qu'entre 0 et 30 on considère que c'est la première corde par ex)
    * cordes[0] correspond à la plus aigue
    * cordes[5] correspond à la plus grave
    */
    var cordes = [0.0, 31.0, 60.0, 90.0, 120.0, 148.0]
    var frettes = [Double]()
    
    init ()
    {
        var screenWidth = UIScreen.mainScreen().bounds.width
        
        if(screenWidth == 480) {
            frettes = [21.0, 143.0, 258.0, 367.0, 468.0, 564.0, 656.0, 742.0, 823.0, 900.0, 971.0, 1046.0, 1105.0, 1165.0, 1223.0, 1277.0, 1328.0, 1375.0, 1422.0, 1464.0, 1505.0, 1543.0, 1579.0, 1613.0, 1645.0]
        }
        else if (screenWidth == 568) {
            frettes = [25.0, 166.0, 299.0, 426.0, 544.0, 656.0, 762.0, 862.0, 956.0, 1040.0, 1130.0, 1208.0, 1284.0, 1353.0, 1421.0, 1485.0, 1544.0, 1599.0, 1652.0, 1703.0, 1749.0, 1795.0, 1835.0, 1875.0, 1913.0]
        }
        else if (screenWidth == 667) {
            frettes = [30.5, 195.0, 351.0, 498.0, 638.0, 769.0, 895.0, 1011.0, 1121.0, 1227.0, 1324.0, 1417.0, 1505.0, 1587.0, 1666.0, 1740.0, 1809.0, 1875.0, 1937.0, 1995.0, 2051.0, 2103.0, 2153.0, 2199.0, 2243.0]
            cordes = [0.0, 35.0, 71.0, 103.0, 139.0, 174.0]
        }
    }
    
    
    /* Donne le numéro de la corde et de la frettes en fonction de la position
    * Entrée : une position x (abscisse) et y (ordonnée) en CGFloat
    * Sortie : un couple (corde, frette)
    */
    
    func pointToPosition(x1: CGFloat, y1: CGFloat) -> (corde: Int, frette: Int){
        
        var frette = 0
        var corde = 0
        
        var x = Double(x1)
        var y = Double(y1)
        
        for var i = 0; i < cordes.count; ++i {
            if ((i+1) > cordes.count) {
                corde = i
            }
            else if (i+1) < cordes.count{
                if (y > cordes[i] && y < cordes[i+1]){
                    
                    corde = i;
                }
                else if (y > cordes[i + 1]) {
                    corde = cordes.count - 1
                }
            }
        }
        
        for var j = 0; j < frettes.count; ++j {
            
            if ((j+1) > frettes.count){
                frette = j
            }
                
            else if (j+1) < frettes.count {
                if (x > frettes[j] && x < frettes[j+1]){
                    frette = j
                    break
                }
            }
        }
        return (corde+1, frette+1)
    }
    
    /*Traduit une note en coordonnées POUR LE MARQUEUR
    Les coordonnées correspondent à la corde et
    au milieu de la frette
    */
    
    func noteToPoint(note: Note) -> (x1: CGFloat, x2: CGFloat){
        var x1 = 0.0 as CGFloat
        
        if (note.corde < cordes.count){
            x1 = CGFloat(cordes[note.corde])
        }
            
        else {
            var distance = CGFloat(cordes[1])
            x1 = CGFloat(cordes[note.corde - 1]) + distance
        }
        
        var x2 = CGFloat(frettes[note.frette - 1]) + ((CGFloat(frettes[note.frette]) - CGFloat(frettes[note.frette - 1])) * 0.8)
        
        return (x1, x2)
    }
    
    /* Donne le coordonnée X de frette le plus proche de xPo
    *  Entrée : une position x (abscisse)
    *  Sortie : un coordonnée X dans self.frettes (Int) le plus proche de xPos
    */
    func closestFret(xPos:Double) -> Double
    {
        var delta = self.frettes[1];
        
        if(self.frettes.count>0 && xPos != 0)
        {
            for var i = 1; i < self.frettes.count; ++i
            {
                delta = self.frettes[i] - xPos;
                
                if( delta > 0)
                {
                    if (delta > (xPos - self.frettes[i - 1])){
                        return self.frettes[i - 1];
                    }
                    return self.frettes[i];
                }
            }
        }
        return 0;
    }
    
    func tapOnNeck(x : CGFloat, y : CGFloat)
    {
        var pos = self.pointToPosition(x, y1: y)
        //println("corde = \(pos.0), frette = \(pos.1)")
        
        var note = Note(frette: pos.1, corde: pos.0);
        superController!.checkNeckAnswer(note)
        
        // println("C'est un \(note.getName()) !")
        
        // println("Partie visible : \(self.contentOffset.x) , \(self.contentOffset.x + self.bounds.width) ")
    }
    
    func getVisiblePart() -> (fretteLeft : Int, fretteRight : Int)
    {
        var curOffset = self.closestFret(Double((self.neckView?.contentOffset.x)!))
        var minFrette = -1;
        var maxFrette = -1;
        var curMax = -1;
        
        for var i = 1; i < self.frettes.count && minFrette == -1 ; ++i
        {
            if CGFloat(self.frettes[i]) > CGFloat(curOffset) {
                minFrette = i
            }
        }
        
        var maxLeft = (CGFloat(self.frettes[minFrette]) + (self.neckView?.frame.size.width)!) - CGFloat(frettes[0])
        
        for var i = minFrette ; i < self.frettes.count && maxFrette == -1; ++i
        {
            if( CGFloat(self.frettes[i - 1]) < maxLeft && CGFloat(self.frettes[i]) <= maxLeft )
            {
                curMax = i-1
            }
            
            if( CGFloat(self.frettes[i ]) > maxLeft && CGFloat(self.frettes[i-1]) < maxLeft ){
                maxFrette = curMax
            }
        }
        
        if(maxFrette == -1){
            maxFrette = self.frettes.count
        }
        
        return (minFrette, maxFrette)
    }
    
    func randomNoteVisible() -> Note
    {
        var visible = self.getVisiblePart()
        
        var rCorde = Int(arc4random_uniform(UInt32(6)) + 1 )
        var rFrette = Int(arc4random_uniform(UInt32(visible.fretteRight - visible.fretteLeft)) + visible.fretteLeft)
        
        if(rCorde <= 0 ) {rCorde = 1}
        if(rFrette <= 0) {rFrette = 1}
        
        return Note(frette: rFrette, corde : rCorde)
    }
    
    
    
    /*Retourne un objet Note proche de la Note donnée en fonction de la partie visible du manche
    dans la neckview */
    
    // Peut encore être améliorée
    
    func findNote(note: Note, bad: String) -> Note {
        var newNote = Note(frette: -1, corde: -1)
        var frettesVisibles = self.getVisiblePart()
        // Pour toutes les cordes et pour toutes les frettes visibles
        // Dans toutes les directions
        
        for var i = note.corde; i <= 6; ++i {
            for var u = note.corde; u >= 1; --u {
                for var j = note.frette; j <= frettesVisibles.1; ++j {
                    for var v = note.frette; v >= frettesVisibles.0; --v {
                        
                        if (Note(frette: note.frette, corde: i).getName() == bad) {
                            newNote = Note(frette: note.frette, corde: i)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote
                        }
                        
                        if (Note(frette: j, corde: note.corde).getName() == bad) {
                            newNote = Note(frette: j, corde: note.corde)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote
                        }
                        
                        if (Note(frette: j, corde: i).getName() == bad) {
                            newNote = Note(frette: j, corde: i)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote;
                        }
                        
                        if (Note(frette: note.frette, corde: u).getName() == bad) {
                            newNote = Note(frette: note.frette, corde: u)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote
                        }
                        
                        if (Note(frette: v, corde: note.corde).getName() == bad) {
                            newNote = Note(frette: v, corde: note.corde)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote
                        }
                        
                        if (Note(frette: v, corde: u).getName() == bad) {
                            newNote = Note(frette: v, corde: u)
                            println("NOTE A DESSINER : corde : \(newNote.corde) frette : \(newNote.frette)")
                            return newNote;
                        }
                        
                    }
                }
            }
            
            if (newNote.corde == -1) {
                for var i = 0; i < 6; ++i {
                    for var j = frettesVisibles.0; j <= frettesVisibles.1; ++j {
                        if (Note(frette: j, corde: i).getName() == bad) {
                            newNote = Note(frette: j, corde:i)
                            return newNote;
                        }
                    }
                }
            }
            
        }
        
        return newNote
    }
    
    func endScroll(){
        self.superController?.endScroll()
    }
    
    func swipeUp(){
        self.superController?.changeMode()
    }
}

