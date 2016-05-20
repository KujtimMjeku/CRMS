package com.crms.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import scala.reflect.internal.annotations.compileTimeOnly;

public class WebAppInitializer implements WebApplicationInitializer {

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
	    AnnotationConfigWebApplicationContext mvcContext = new AnnotationConfigWebApplicationContext();
	    mvcContext.register(WebConfig.class);

	    // Link Application Context to Serlvet Context
	    servletContext.addListener(new ContextLoaderListener(mvcContext));
	    DispatcherServlet dispatch=new DispatcherServlet(mvcContext);
	    dispatch.setThrowExceptionIfNoHandlerFound(true);
	    
	    // Register and map the dispatcher servlet
	    ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", dispatch);
	    dispatcher.setLoadOnStartup(1);
	    dispatcher.addMapping("/");
	}

	private AnnotationConfigWebApplicationContext getContext() {
		AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
		context.setConfigLocation("com.crms.config.WebConfig");
		return context;
	}


}
