fun main(args: Array<String>){
    val numerator: Int = 19
    val denominator: Int = 10
    println(numerator%denominator)
    println(trueOrFalse(numerator%denominator == 0))
    println(numerator/denominator)

    val i = 0          // Infers Int
    val l1 = 0L        // L creates Long
    val l2: Long = 0   // Explicit type
    println("$l1 $l2")
    println(Long.MAX_VALUE)
}



