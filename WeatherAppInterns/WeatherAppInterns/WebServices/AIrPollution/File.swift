/*
 @StateObject -> Objeto que puede publicar valores
      |
      |
      ------> @Publisher var emoji -> Notifica el cambio
  ___      ___
 | A | -> | B |
            |
            |
             ----> @Binding var emoji
 */


/*
 $forecast ----> Binding<forecast>
 forecast -----> forecast
 
 $emoji ----> Binding<😎>
 emoji -----> 😎
 
 ForEach(data: [Movie], id: \.<identificador_unico>) { movie in
 
 }
 */
