import UIKit

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
