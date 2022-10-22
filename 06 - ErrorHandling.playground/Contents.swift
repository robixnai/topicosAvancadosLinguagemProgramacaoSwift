import UIKit

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
