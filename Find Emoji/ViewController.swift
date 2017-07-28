//
//  ViewController.swift
//  Find Emoji
//
//  Created by Jorge Lopez Gil on 28/7/17.
//  Copyright © 2017 Jorge Lopez Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    @IBOutlet var lblVidas: UILabel!
    @IBOutlet var lblPuntos: UILabel!
    @IBOutlet var lblEmoji: UILabel!
    var vidas: Int = 5
    var derrotas: Int = 0
    var puntos: Int = 0
    var emoji: String = ""
    @IBOutlet var txtUser: UITextField!
    
    //Inicio de la app
    override func viewDidLoad() {
        super.viewDidLoad()
        emoji = randomEmoji()
        cargarVisual()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func checkEmoji(_ sender: UIButton) {
        //Comprueba valores
        let user = txtUser.text
        if user != emoji {
            //Vida menos
            if vidas > 0 {
                derrotas += 1
                vidas -= 1
            } else {
                alertaFin()
            }
        } else {
            //Acierto
            puntos += 5
            emoji = randomEmoji()
        }
        
        //Refresca resultados
        cargarVisual()
    }

    //Actualiza los elementos visuales
    func cargarVisual(){
        //Vidas
        var textoVidas: String = ""
        textoVidas = "\(generaVidas(cantidad: vidas, corazon: "❤️", derrota: "🖤")) Vidas"
        lblVidas.text = textoVidas
        
        //Puntos
        let textoPuntos: String = "\(puntos) Puntos"
        lblPuntos.text = textoPuntos
        
        //Emoji
        lblEmoji.text = "\(emoji)"
        
        //Borramos texto
        txtUser.text = ""
    }
    
    //Genera cadena String de las vidas
    func generaVidas(cantidad: Int, corazon: String, derrota: String) -> String{
        var cadena: String = ""
        print("Se procede con ", vidas, " vidas y ", derrotas, " derrotas")
        for i in 0..<cantidad
        {
            cadena += corazon
            print("Corazón Nº \(i) generado")
        }
        for i in 0..<derrotas {
            cadena += derrota
            print("Corazón roto Nº \(i) generado")
        }
        return cadena
    }
    
    //Alerta partida perdida
    func alertaFin(){
        let alertFin: UIAlertController = UIAlertController(title: "Has perdido! 😧", message: "Has conseguido llegar a \(puntos) Puntos, siguie entrenando para conseguir un record!", preferredStyle: .alert)
        let resetAction: UIAlertAction = UIAlertAction(title: "Reiniciar", style: .destructive) { (resetAPP) in self.reiniciar() }
        
        alertFin.addTextField { (textField) in textField.placeholder = "Introduce tu nombre"}
        alertFin.addAction(resetAction)
        alertFin.addAction(UIAlertAction(title: "Guardar", style: .default, handler: { [weak alertFin] (_) in
            let textField = alertFin?.textFields![0] // Force unwrapping because we know it exists.
            self.guardar(Usuario: textField!.text!)
        }))
        present(alertFin, animated: true, completion: nil)
    }
    
    //Genera emoji aleatorio
    func randomEmoji() -> String{
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        let emojiR = UnicodeScalar(ascii)?.description
        return emojiR!
    }
    
    //Reseteo app
    func reiniciar(){
        print("Se ha reiniciado el juego!")
        vidas = 5
        derrotas = 0
        puntos = 0
        emoji = randomEmoji()
        
        cargarVisual()
    }
    
    //Guardado de datos
    func guardar(Usuario: String){
        print("Se guarda los ", puntos, " Puntos obtenidos por ", Usuario)
        reiniciar()
    }
}

