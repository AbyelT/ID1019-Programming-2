public class Thread {
    private Runnable runnable;

    public Thread(Runnable r){
        this.runnable = r;
    }

    public void start() {
        runnable.run();
    }
}