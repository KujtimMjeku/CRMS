package com.crms.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.ehcache.EhCacheFactoryBean;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.PermissionEvaluator;
import org.springframework.security.access.expression.method.DefaultMethodSecurityExpressionHandler;
import org.springframework.security.access.expression.method.MethodSecurityExpressionHandler;
import org.springframework.security.acls.AclPermissionCacheOptimizer;
import org.springframework.security.acls.AclPermissionEvaluator;
import org.springframework.security.acls.domain.AclAuthorizationStrategy;
import org.springframework.security.acls.domain.AclAuthorizationStrategyImpl;
import org.springframework.security.acls.domain.ConsoleAuditLogger;
import org.springframework.security.acls.domain.DefaultPermissionGrantingStrategy;
import org.springframework.security.acls.domain.EhCacheBasedAclCache;
import org.springframework.security.acls.jdbc.BasicLookupStrategy;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.acls.jdbc.LookupStrategy;
import org.springframework.security.acls.model.PermissionGrantingStrategy;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.GlobalMethodSecurityConfiguration;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class WebSecurityACL extends GlobalMethodSecurityConfiguration {

	@Bean
	EhCacheBasedAclCache aclCache() {
		EhCacheFactoryBean factoryBean = new EhCacheFactoryBean();
		EhCacheManagerFactoryBean cacheManager = new EhCacheManagerFactoryBean();

		factoryBean.setCacheName("aclCache");
		factoryBean.setCacheManager(cacheManager.getObject());
		factoryBean.afterPropertiesSet();

		return new EhCacheBasedAclCache(factoryBean.getObject(), permissionGrantingStrategy(),
				aclAuthorizationStrategy());
	}

	@Bean
	AclAuthorizationStrategy aclAuthorizationStrategy() {
		return new AclAuthorizationStrategyImpl(new SimpleGrantedAuthority("ROLE_ACL_ADMIN"));
	}

	@Bean
	PermissionGrantingStrategy permissionGrantingStrategy() {
		return new DefaultPermissionGrantingStrategy(new ConsoleAuditLogger());
	}

	@Bean
	@Autowired
	LookupStrategy lookupStrategy(DataSource dataSource) {
		return new BasicLookupStrategy(dataSource, aclCache(), aclAuthorizationStrategy(),
				permissionGrantingStrategy());
	}

	@Bean
	@Autowired
	JdbcMutableAclService aclService(DataSource dataSource, LookupStrategy lookupStrategy) {
		JdbcMutableAclService service = new JdbcMutableAclService(dataSource, lookupStrategy, aclCache());
		 service.setClassIdentityQuery("select currval(pg_get_serial_sequence('acl_class', 'id'))");
		 service.setSidIdentityQuery("select currval(pg_get_serial_sequence('acl_sid', 'id'))");
		return service;
	}

	@Bean	
	@Autowired
	PermissionEvaluator permissionEvaluator(JdbcMutableAclService aclService) {
		return new AclPermissionEvaluator(aclService);
	}

	@Bean
	@Autowired
	AclPermissionCacheOptimizer aclPermissionCacheOptimizer(JdbcMutableAclService aclService) {
		return new AclPermissionCacheOptimizer(aclService);
	}

	@Autowired
	JdbcMutableAclService aclservice;

	@Override
	protected MethodSecurityExpressionHandler createExpressionHandler() {
		DefaultMethodSecurityExpressionHandler expressionHandler = new DefaultMethodSecurityExpressionHandler();

		expressionHandler.setPermissionEvaluator(permissionEvaluator(aclservice));
		expressionHandler.setPermissionCacheOptimizer(aclPermissionCacheOptimizer(aclservice));

		return expressionHandler;
	}
}