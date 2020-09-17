fun main(args: Array<String>){
    val y: Boolean = false

    if(!y)
        println("!y is true")

    val b = 1
    println(trueOrFalse(b == 1))
}

fun trueOrFalse(exp: Boolean): String{
    if(exp)
        return "It's true"
    return "It's false"
}

