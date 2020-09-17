package tarefa1;

import java.lang.Thread;

public class ThreadCreator {
    public static void main(String[] args){
        System.out.println("Creating threads");
        Thread thread_1 = new Thread(new PrintTask("task1"));
        Thread thread_2 = new Thread(new PrintTask("task2"));
        Thread thread_3 = new Thread(new PrintTask("task3"));

        System.out.println("Threads created, starting tasks");

        thread_1.start();
        thread_2.start();
        thread_3.start();

        System.out.println("Tasks started, main ends.\n");
    }
}
