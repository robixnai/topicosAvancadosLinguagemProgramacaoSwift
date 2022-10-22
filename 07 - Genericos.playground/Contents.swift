import UIKit

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
