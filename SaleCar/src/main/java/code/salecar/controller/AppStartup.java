package code.salecar.controller;

import code.salecar.service.product.promotion.PromotionScheduler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebListener
public class AppStartup implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        PromotionScheduler.start();

        System.out.println("Promotion engine started");
    }
}