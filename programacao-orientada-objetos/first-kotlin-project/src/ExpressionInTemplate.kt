fun main(args: Array<String>){
    val condition = true
    println("${if (condition) 'a' else 'b'}")
    val s = "value"
    println("s = \"$s\".")
    println("""
        s = "$s".
    """.trimIndent())
}



