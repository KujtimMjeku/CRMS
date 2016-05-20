package com.crms.config;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
@PropertySource(value={"classpath:application.properties"})
public class MailConfig {
	
	@Autowired
	private Environment environment;
	
	@Bean
    public JavaMailSender javaMailService() {
		Properties mailProperties = new Properties();
	    mailProperties.put("mail.smtp.auth", environment.getProperty("spring.mail.properties.mail.smtp.auth"));
	    mailProperties.put("mail.smtp.socketFactory.port", environment.getProperty("spring.mail.properties.mail.smtp.socketFactory.port"));
	    mailProperties.put("mail.smtp.socketFactory.class", environment.getProperty("spring.mail.properties.mail.smtp.socketFactory.class"));
	    mailProperties.put("mail.smtp.socketFactory.fallback", environment.getProperty("spring.mail.properties.mail.smtp.socketFactory.fallback"));
	    mailProperties.put("mail.smtp.starttls.enable", environment.getProperty("spring.mail.properties.mail.smtp.starttls.enable"));
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        javaMailSender.setHost(environment.getProperty("spring.mail.host"));
        javaMailSender.setUsername(environment.getProperty("spring.mail.username"));
        javaMailSender.setPassword(environment.getProperty("spring.mail.password"));
        javaMailSender.setJavaMailProperties(mailProperties);
        return javaMailSender;
    }


}
