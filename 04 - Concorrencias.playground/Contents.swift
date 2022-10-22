import UIKit

// CONCORRENCIAS
/* Use async para marcar uma função que é executada de forma assíncrona. */
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

/* Você marca uma chamada para uma função assíncrona escrevendo await na frente dela. */
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "João Souza"
    }
    return "Convidado"
}

/*
 Use async let para chamar uma função assíncrona, permitindo que ela seja executada em paralelo com outro código assíncrono.
 Quando você usa o valor que ele retorna, escreva await.
 */
func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Olá \(username), user ID \(userID)"
    print(greeting)
}

/* Use Task para chamar funções assíncronas de código síncrono, sem esperar que elas retornem. */
Task {
    await connectUser(to: "primary")
}
