package com.swaroop.apmsimplespringboot;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class HelloController {

    @GetMapping("/info")
    public void info() {
       log.info("INFO message **********************");
    }


    @GetMapping("/error")
    public void error() {
        log.error("ERROR message **********************");
    }

    @GetMapping("/exception")
    public void errorWithException() throws Exception {
        try {
            if(true){
                throw new Exception("Exception happened*****************");
            }
        } catch (Exception e) {
            log.error("ERROR message **********************", e);
            throw e;
        }

    }
}