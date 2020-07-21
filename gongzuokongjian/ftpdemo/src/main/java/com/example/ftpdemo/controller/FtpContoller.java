package com.example.ftpdemo.controller;

import org.apache.ftpserver.FtpServer;
import org.apache.ftpserver.FtpServerFactory;
import org.apache.ftpserver.ftplet.Authority;
import org.apache.ftpserver.ftplet.FtpException;
import org.apache.ftpserver.listener.ListenerFactory;
import org.apache.ftpserver.usermanager.PropertiesUserManagerFactory;
import org.apache.ftpserver.usermanager.impl.BaseUser;
import org.apache.ftpserver.usermanager.impl.WritePermission;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.PostConstruct;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author teswell
 * @Date 2020/7/20 11:01
 * @function
 */
@Controller
public class FtpContoller {
    @Value("${server.port}")
    private int prot;

    @PostConstruct
    public void initFace() throws FtpException {
        FtpServerFactory serverFactory = new FtpServerFactory(); //ftp工厂

        ListenerFactory factory = new ListenerFactory();   //监听工厂
        //设置监听端口
        factory.setPort(8085);

        //替换默认监听
        serverFactory.addListener("default", factory.createListener());

        //用户名
        BaseUser user = new BaseUser();
        user.setName("admin");
        //密码 如果不设置密码就是匿名用户
        user.setPassword("123456");
        //用户主目录
        user.setHomeDirectory("d:\\gongzuokongjian");

        List<Authority> authorities = new ArrayList<Authority>();
        //增加写权限
        authorities.add(new WritePermission());
        user.setAuthorities(authorities);

        //增加该用户
        serverFactory.getUserManager().save(user);

        /**
         * 也可以使用配置文件来管理用户
         */
//	    PropertiesUserManagerFactory userManagerFactory = new PropertiesUserManagerFactory();
//	    userManagerFactory.setFile(new File("users.properties"));
//	    serverFactory.setUserManager(userManagerFactory.createUserManager());

        FtpServer server = serverFactory.createServer();
        server.start();

    }

    @Controller
    public class IndexController {
        @RequestMapping("/index")
        @ResponseBody
        public String index() {
            return "helloword!";
        }
    }

}
