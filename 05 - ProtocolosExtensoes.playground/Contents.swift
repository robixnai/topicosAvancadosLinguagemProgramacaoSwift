import UIKit

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
