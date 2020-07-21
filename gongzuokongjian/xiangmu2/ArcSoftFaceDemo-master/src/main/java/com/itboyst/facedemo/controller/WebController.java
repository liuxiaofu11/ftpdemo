package com.itboyst.facedemo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author teswell
 */
@Controller
public class WebController {

    @RequestMapping(value = "/")
    public String index(Model model) {
        return "face_detect";
    }

    @RequestMapping(value = "/faceDetect")
    public String detect(Model model) {
        return "face_detect";
    }

    @RequestMapping(value = "/faceSimilarity")
    public String compare(Model model) {
        return "face_similarity";
    }
    @RequestMapping(value = "/faceRecognition")
    public String recognition(Model model) {
        return "face_recognition";
    }

}
