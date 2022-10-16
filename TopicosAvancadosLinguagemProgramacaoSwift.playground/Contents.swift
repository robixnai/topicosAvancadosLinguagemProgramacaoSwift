import UIKit

// FUNÇÕES E CLOSURES
/* Vamos criar uma função e ver como usar */
func greet(person: String, day: String) -> String {
    return "Olá \(person), hoje é \(day)."
}
greet(person: "José", day: "terça-feira")
/*
 Por padrão, as funções usam seus nomes de parâmetros como labels para seus argumentos.
 Escreva um label de argumento personalizado antes do nome do parâmetro ou escreva _ para não usar nenhum label de argumento.
 */
func greet(_ person: String, on day: String) -> String {
    return "Olá \(person), hoje é \(day)."
}
greet("José", on: "quarta-feira")
/*
 Use uma tupla para criar um valor composto — por exemplo, para retornar vários valores de uma função.
 Os elementos de uma tupla podem ser referidos pelo nome ou pelo número.
 */
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum) // Prints "120"
print(statistics.2) // Prints "120"
/*
 As funções podem ser aninhadas.
 Funções aninhadas têm acesso a variáveis que foram declaradas na função externa.
 Você pode usar funções aninhadas para organizar o código em uma função longa ou complexa.
 */
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
/*
 As funções são um tipo de primeira classe.
 Isso significa que uma função pode retornar outra função como seu valor.
 */
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
/* Uma função pode receber outra função como um de seus argumentos. */
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)
/*
 As funções são, na verdade, um caso especial de closures: blocos de código que podem ser chamados posteriormente.
 O código em uma closure tem acesso a coisas como variáveis e funções que estavam disponíveis no escopo onde a closure foi criada, mesmo que a closure esteja em um escopo diferente quando é executada – você viu um exemplo disso já com funções aninhadas.
 Você pode escrever uma closure sem nome envolvendo o código com chaves ({}).
 Use in para separar os argumentos e o tipo de retorno do corpo.
 */
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
/*
 Você tem várias opções para escrever closures de forma mais concisa.
 Quando o tipo de closures já é conhecido, como o retorno de chamada para um delegate, você pode omitir o tipo de seus parâmetros, seu tipo de retorno ou ambos.
 Closures de instrução única retornam implicitamente o valor de sua única instrução.
 */
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers) // Prints "[60, 57, 21, 36]"
/*
 Você pode fazer referência a parâmetros por número em vez de nome — essa abordagem é especialmente útil em closures muito curtas.
 Uma closures passado como último argumento para uma função pode aparecer imediatamente após os parênteses.
 Quando uma closures é o único argumento para uma função, você pode omitir totalmente os parênteses.
 */
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers) // Prints "[20, 19, 12, 7]"



/* ============================================================================================================================================ */
// CLASSES E OBJETOS
/* Vamos criar uma classe */
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "Uma forma com \(numberOfSides) lados."
    }
}
/*
 Crie uma instância de uma classe colocando parênteses após o nome da classe.
 Use a sintaxe de ponto para acessar as propriedades e métodos da instância.
 */
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
/*
 Esta versão da classe Shape está faltando algo importante: um inicializador para configurar a classe quando uma instância é criada.
 Use init para criar um inicializador.
 */
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "Uma forma com \(numberOfSides) lados."
    }
}
/*
 Observe como self é usado para distinguir a propriedade name do argumento name para o inicializador.
 Os argumentos para o inicializador são passados como uma chamada de função quando você cria uma instância da classe.
 Cada propriedade precisa de um valor atribuído - em sua declaração (como numberOfSides) ou no inicializador (como name).
 Use deinit para criar um desinicializador se precisar realizar alguma limpeza antes que o objeto seja desalocado da memória.
 
 As subclasses incluem o nome da superclasse após o nome da classe, separados por dois pontos.
 Não há necessidade de classes para subclassificar qualquer classe raiz padrão, então você pode incluir ou omitir uma superclasse conforme necessário.
 Os métodos em uma subclasse que substituem a implementação da superclasse são marcados com override - substituir um método por acidente, sem override, é detectado pelo compilador como um erro.
 O compilador também detecta métodos com override que não substituem nenhum método na superclasse.
 */
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "Um quadrado com lados de comprimento \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "meu quadrado de teste")
test.area()
test.simpleDescription()
/* Além das propriedades simples que são armazenadas, as propriedades podem ter um getter e um setter. */
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter) // Prints "9.3"
triangle.perimeter = 9.9
print(triangle.sideLength) // Prints "3.3000000000000003"
/*
 No setter para perimeter, o novo valor tem o nome implícito newValue.
 Você pode fornecer um nome explícito entre parênteses após definir.
 Observe que o inicializador da classe EquilateralTriangle tem três etapas diferentes:
 1 - Configurando o valor das propriedades que a subclasse declara.
 2 - Chamando o inicializador da superclasse.
 3 - Alterando o valor das propriedades definidas pela superclasse.
     Qualquer trabalho de configuração adicional que use métodos, getters ou setters também pode ser feito neste ponto.
 Se você não precisar calcular a propriedade, mas ainda precisar fornecer o código que é executado antes e depois de definir um novo valor, use willSet e didSet.
 O código que você fornece é executado sempre que o valor muda fora de um inicializador.
 Vamos ver um exemplo onde garantimos que o comprimento do lado de seu triângulo seja sempre igual ao comprimento do lado de seu quadrado.
 */
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "outra forma de teste")
print(triangleAndSquare.square.sideLength) // Prints "10.0"
print(triangleAndSquare.triangle.sideLength) // Prints "10.0"
triangleAndSquare.square = Square(sideLength: 50, name: "quadrado maior")
print(triangleAndSquare.triangle.sideLength) // Prints "50.0"
/*
 Ao trabalhar com valores opcionais, você pode escrever ? antes de operações como métodos, propriedades e subscripting.
 Se o valor antes do ? é nil, tudo depois do ? é ignorado e o valor de toda a expressão é nulo.
 Caso contrário, o valor opcional é desempacotado e tudo após o ? atua sobre o valor desembrulhado.
 Em ambos os casos, o valor da expressão inteira é um valor opcional.
 */
let optionalSquare: Square? = Square(sideLength: 2.5, name: "quadrado opcional")
let sideLength = optionalSquare?.sideLength



/* ============================================================================================================================================ */
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



/* ============================================================================================================================================ */
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



/* ============================================================================================================================================ */
// PROTOCOLO E EXTENSÕES
/* Use protocol para declarar um protocolo. */
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
/* Classes, Enuns e Structs podem adotar protocolos. */
// Class
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "Uma Classe muito simples."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Agora 100% ajustado."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "Uma Structs simples"
    mutating func adjust() {
        simpleDescription += " (ajustado)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
/*
 Observe o uso da palavra-chave mutating na declaração de SimpleStructure para marcar um método que modifica a estrutura.
 A declaração de SimpleClass não precisa de nenhum de seus métodos marcados como mutantes porque os métodos em uma classe sempre podem modificar a classe.
 
 Use a extension para adicionar funcionalidade a um tipo existente, como novos métodos e propriedades computadas.
 Você pode usar uma extensão para adicionar conformidade de protocolo a um tipo declarado em outro lugar ou até mesmo a um tipo que você importou de uma biblioteca ou framework.
 */
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "O número \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription) // Prints "O número 7"
/*
 Você pode usar um nome de protocolo como qualquer outro tipo nomeado — por exemplo, para criar uma coleção de objetos que tenham tipos diferentes, mas que estejam todos em conformidade com um único protocolo.
 Quando você trabalha com valores cujo tipo é um tipo de protocolo, os métodos fora da definição de protocolo não estão disponíveis.
 */
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription) // Prints "Uma Classe muito simples. Agora 100% ajustado."
//print(protocolValue.anotherProperty)  // Descomentar para ver o erro
/*
 Mesmo que a variável protocolValue tenha um tipo de tempo de execução de SimpleClass, o compilador o trata como o tipo fornecido de ExampleProtocol.
 Isso significa que você não pode acessar acidentalmente métodos ou propriedades que a classe implementa além de sua conformidade com o protocolo.
 */



/* ============================================================================================================================================ */
// ERROR HANDLING
/* Você representa erros usando qualquer tipo que adote o protocolo Error. */
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
/*
 Use throw para lançar um erro e throws para marcar uma função que pode lançar um erro.
 Se você lançar um erro em uma função, a função retornará imediatamente e o código que chamou a função tratará o erro.
 */
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Não possui toner" {
        throw PrinterError.noToner
    }
    return "Trabalho enviado"
}
/*
 Existem várias maneiras de lidar com erros.
 Uma maneira é usar do-catch.
 Dentro do bloco do, você marca o código que pode gerar um erro escrevendo try na frente dele.
 Dentro do bloco catch, o erro recebe automaticamente o nome error, a menos que você dê um nome diferente.
 */
do {
    let printerResponse = try send(job: 1040, toPrinter: "Folha Pagamento")
    print(printerResponse) // Prints "Trabalho enviado"
} catch {
    print(error)
}
/*
 Você pode fornecer vários blocos catch que tratam de erros específicos.
 Você escreve um padrão depois de catch, assim como faz depois de case em um switch.
 */
do {
    let printerResponse = try send(job: 1440, toPrinter: "Fotos Praia")
    print(printerResponse) // Prints "Trabalho enviado"
} catch PrinterError.onFire {
    print("Pegou fogo em tudo.")
} catch let printerError as PrinterError {
    print("Erro na impressora: \(printerError).")
} catch {
    print(error)
}
/*
 Outra maneira de lidar com erros é usar try? para converter o resultado em um opcional.
 Se a função lançar um erro, o erro específico será descartado e o resultado será nulo.
 Caso contrário, o resultado é um opcional contendo o valor que a função retornou.
 */
let printerSuccess = try? send(job: 1884, toPrinter: "Memorando")
let printerFailure = try? send(job: 1885, toPrinter: "Não possui toner")
/*
 Use defer para escrever um bloco de código que é executado após todos os outros códigos na função, pouco antes do retorno da função.
 O código é executado independentemente de a função gerar um erro.
 Você pode usar o defer para escrever o código de configuração e limpeza um ao lado do outro, mesmo que eles precisem ser executados em momentos diferentes.
 */
var fridgeIsOpen = false
let fridgeContent = ["leite", "ovos", "sobras"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }

    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen) // Prints "false"



/* ============================================================================================================================================ */
// GENÉRICOS
/* Escreva um nome entre colchetes angulares para criar uma função ou tipo genérico. */
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result: [Item] = []
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "bater", numberOfTimes: 4)
/*
 Você pode criar formas genéricas de funções e métodos, bem como Classes, Enuns e Structs.
 Vamos reimplementar o tipo opcional da biblioteca padrão Swift
 */
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
/* Use where logo antes do corpo para especificar uma lista de requisitos — por exemplo, exigir que o tipo implemente um protocolo, exigir que dois tipos sejam iguais ou exigir que uma classe tenha uma superclasse específica. */
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Element: Equatable, T.Element == U.Element
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3])
