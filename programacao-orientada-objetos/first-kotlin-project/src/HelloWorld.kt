fun main(args: Array <String>){
    println("hey there!")
    var whole = 11
    println(whole)
    //val whole = 13 gives an error
    println("Sally"+5.9)
    //println("Sally"*5.9) gives an error because string cannot be multiplied
    val fractional: Double = 1.4
    val trueOrFalse: Boolean = true
    val words: String = "A value"
    val character: Char = 'x'
    val lines: String = """
        Triple quotes let u have many lines in your string
    """.trimIndent()
    println("$fractional, $trueOrFalse, $words, $character, $lines")
    println(multpiply_a_b(3, 2))
}

fun multpiply_a_b(variable_a: Int, variable_b: Int): Int{
    return variable_a * variable_b
}

/*
    var for mutable variables
    val for immutable variables
*/