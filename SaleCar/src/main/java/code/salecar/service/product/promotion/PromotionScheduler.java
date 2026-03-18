package code.salecar.service.product.promotion;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class PromotionScheduler {
    public static void start(){
        System.out.println("Scheduler starting...");

        ScheduledExecutorService scheduler =
                Executors.newSingleThreadScheduledExecutor();

        PromotionEngine engine = new PromotionEngine();

        scheduler.scheduleAtFixedRate(
                () -> {
                    System.out.println("PromotionEngine running...");
                    engine.run();
                },
                0,
                5,
                TimeUnit.MINUTES
        );
    }
}
