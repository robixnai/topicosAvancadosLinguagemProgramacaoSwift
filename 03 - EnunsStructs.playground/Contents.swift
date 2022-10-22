import UIKit

// ENUNS E STRUCTS
/*
 Use enum para criar uma enumeração.
 Assim como as classes e todos os outros tipos nomeados, as enumerações podem ter métodos associados a elas.
 */
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
let aceRawValue = ace.rawValue

/*
 Por padrão, o Swift atribui os valores brutos começando em zero e incrementando em um a cada vez, mas você pode alterar esse comportamento especificando valores explicitamente.
 No exemplo do enum Rank, Ace recebe explicitamente um valor bruto de 1, e o restante dos valores brutos são atribuídos em ordem.
 Você também pode usar strings ou números de ponto flutuante como o tipo bruto de uma enumeração.
 Use a propriedade rawValue para acessar o valor bruto de um caso de enumeração.
 
 Use o inicializador init?(rawValue:) para criar uma instância de uma enumeração de um valor bruto.
 Ele retorna o caso de enumeração correspondente ao valor bruto ou nil se não houver nenhum valor correspondente.
 */
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

/*
 Os valores case de um enum são valores reais, não apenas outra maneira de escrever seus valores brutos.
 Na verdade, nos casos em que não há um valor bruto significativo, você não precisa fornecer um.
 */
enum Suit {
    case spades, hearts, diamonds, clubs

    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

/*
 Observe as duas maneiras pelas quais o caso hearts do enum Suit é referido:
 Ao atribuir um valor à constante hearts, o caso de enumeração Suit.hearts é referido por seu nome completo porque a constante não tem um tipo explícito especificado.
 Dentro do switch, o caso do enum é referido pela forma abreviada .hearts porque o valor de self já é conhecido como um naipe.
 Você pode usar a forma abreviada sempre que o tipo do valor já for conhecido.
 
 Se um enum tiver valores brutos, esses valores serão determinados como parte da declaração, o que significa que cada instância de um caso do enum específico sempre terá o mesmo valor bruto.
 Outra opção para casos de enumeração é ter valores associados ao caso — esses valores são determinados quando você cria a instância e podem ser diferentes para cada instância de um caso de enumeração.
 Você pode pensar nos valores associados como se comportando como propriedades armazenadas da instância do caso de enumeração.
 Por exemplo, considere o caso de solicitar os horários de nascer e pôr do sol de um servidor.
 O servidor responde com as informações solicitadas ou responde com uma descrição do que deu errado.
 Vamos ver na prática:
 */
enum ServerResponse {
    case result(String, String)
    case failure(String)
}
let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Fora do intervalo.")
switch success {
case let .result(sunrise, sunset):
    print("O nascer do sol é \(sunrise) e o pôr do sol é \(sunset).")
case let .failure(message):
    print("Falha...  \(message)")
}

/*
 Observe como os horários do nascer e do pôr do sol são extraídos do valor ServerResponse como parte da correspondência do valor com os casos de comutação.

 Use struct para criar uma estrutura.
 As estruturas suportam muitos dos mesmos comportamentos que as classes, incluindo métodos e inicializadores.
 Uma das diferenças mais importantes entre estruturas e classes é que as estruturas são sempre copiadas quando são passadas em seu código, mas as classes são passadas por referência.
 Structs são values type
 Classes são reference type
 */
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "O \(rank.simpleDescription()) do \(suit.simpleDescription())"
    }
}
let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
