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
