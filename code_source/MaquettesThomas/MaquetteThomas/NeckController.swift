

import UIKit
import Darwin

class NeckController {
    


   /* Coordonnées des cordes avec une amplitude
    * (c'est-à-dire qu'entre 0 et 30 on considère que c'est la première corde par ex)
    * cordes[0] correspond à la plus aigue
    * cordes[5] correspond à la plus grave
    */
    var cordes = [0, 35, 72, 106, 141, 176]
    
    /* Coordonnées des frettes */
    var frettes = [0, 196, 353, 502, 640, 774, 896, 1014, 1124, 1229, 1328, 1421, 1509, 1593, 1670, 1774,
        1814, 1881, 1942, 2002, 2057, 2109, 2157, 2205, 2249]

    
    /* Donne le numéro de la corde et de la frettes en fonction de la position
     * Entrée : une position x (abscisse) et y (ordonnée) en CGFloat
     * Sortie : un couple (corde, frette)
    */
    
    func pointToPosition(x1: CGFloat, y1: CGFloat) -> (corde: Int, frette: Int){
    
        var frette = 0
        var corde = 0
        
        var x = Int(x1)
        var y = Int(y1)
        
        for var i = 0; i < cordes.count; ++i {
            if ((i+1) > cordes.count) {
                corde = i
            }
            else if (i+1) < cordes.count{
                if (y > cordes[i] && y < cordes[i+1]){
                   
                    corde = i;
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
    

    

    
    /* Donne le coordonnée X de frette le plus proche de xPos
    *  Entrée : une position x (abscisse)
    *  Sortie : un coordonnée X dans self.frettes (Int) le plus proche de xPos
    */
    func closestFret(xPos:Int) -> Int {
        var curCloser = self.frettes[1];
        
        if(self.frettes.count>0 && xPos != 0)
        {
            curCloser = self.frettes[1]-xPos;
            
            for var i = 1; i < self.frettes.count; ++i
            {
                if( (self.frettes[i]-xPos) < 0)
                {
                    curCloser = (self.frettes[i]-xPos);
                }
                else{
                    return self.frettes[i];
                }
            }
        }
        return 0;
    }
    
    
    /* Retourne une abscisse en aléatoire entre x1 (compris) et x2 (non compris)
     * Tire une frette aléatoirement
     * Entrée : x1 -> abscisse de début
     *          x2 -> abscisse de fin
     * Sortie : x, une abscisse tirée aléatoirement
     */
    
    func randomX(x1: CGFloat, x2: CGFloat) -> Int{
        var x = 0
        var fin = 0
        println("x1 = \(x1) et x2 = \(x2)")
        var debut = pointToPosition(x1+1, y1: 0).frette
        
        // -1 car il va retourner la frette la plus à droite,
        // mais elle sera probablement coupée alors on prend la frette d'avant

        fin = pointToPosition(x2, y1: 0).frette


        x = Int(arc4random_uniform(UInt32(fin - debut)) + debut)
        
        return x;
    }
    
    func randomY() -> Int {
        var y = Int(arc4random_uniform(UInt32(7 - 1)) + 1)
        return y
    }
    
    func randomNote(x1: CGFloat, x2: CGFloat) -> String {
        var note: Note;
        
        var f = randomX(x1, x2: x2)
        var c = randomY()
        
        println("frette : \(f) corde : \(c)")
    
        note = Note(frette: c, corde: f)
        println("NOTE TIREE ALEATOIREMENT = \(note.getName()) : ")
        
        return note.getName()
    }
}

