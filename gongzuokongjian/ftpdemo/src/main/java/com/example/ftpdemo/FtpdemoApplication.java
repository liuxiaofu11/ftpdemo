package com.example.ftpdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class FtpdemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(FtpdemoApplication.class, args);
        System.out.println("springboot启动成功");
    }

}
